Received: from eggs.gnu.org ([2001:4830:134:3::10]:39483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyZDP-0008Nl-KI
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyZDM-0005aA-H2
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:30:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cyZDM-0005ZK-BC
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:30:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52C357D0DE
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 07:30:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170406210917.6896-1-eblake@redhat.com>
	<c294a578-31ee-8f53-807e-82aa355df80d@redhat.com>
Date: Thu, 13 Apr 2017 09:30:45 +0200
In-Reply-To: <c294a578-31ee-8f53-807e-82aa355df80d@redhat.com> (Paolo
	Bonzini's message of "Thu, 13 Apr 2017 14:11:26 +0800")
Message-ID: <87y3v4ojbu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/04/2017 05:09, Eric Blake wrote:
>
>> qemu_kill_report() is already able to tell whether a shutdown
>> was triggered by guest action (no output) or by a host signal
>> (a message about termination is printed via error_report); but
>> this information is then lost.  Libvirt would like to be able
>> to distinguish between a SHUTDOWN event triggered solely by
>> guest request and one triggered by a SIGTERM on the host.
>>
>> Enhance the SHUTDOWN event to pass the value of shutdown_signal
>> through to the monitor client, suitably remapped into a
>> platform-neutral string.  Note that mingw lacks decent signal
>> support, and will never report a signal because it never calls
>> qemu_system_killed().
>>
>> See also https://bugzilla.redhat.com/1384007
>> 
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> I think this patch is fine for now; calling qemu_system_killed() from
> os-win32.c is an orthogonal improvement.

Fair enough.  However, I think the patch misses its stated goal even on
POSIX hosts: to let libvirt distinguish host- and guest-initiated
shutdown.  Shutdown on signal is only one kind of host-initiated
shutdown.  All the others remain indistinguishable from guest-initiated
shutdown.

To reach the goal, we can track all host-initiated shutdowns, or all
guest-initiated shutdowns.  Pick the one that's easier to track.  The
former probably involves messing with OS-specific code, the latter
probably doesn't.
