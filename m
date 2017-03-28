Received: from eggs.gnu.org ([2001:4830:134:3::10]:58791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cslb8-0002TE-4F
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cslb4-0006bQ-R0
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cslb4-0006bA-Lb
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:31:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0059C05683F
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 07:31:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-3-git-send-email-armbru@redhat.com>
	<20170327213407.GJ15423@localhost.localdomain>
Date: Tue, 28 Mar 2017 09:31:15 +0200
In-Reply-To: <20170327213407.GJ15423@localhost.localdomain> (Jeff Cody's
	message of "Mon, 27 Mar 2017 17:34:07 -0400")
Message-ID: <87wpb96enw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 02/11] rbd: Fix to cleanly
 reject -drive without pool or image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

Jeff Cody <jcody@redhat.com> writes:

> On Mon, Mar 27, 2017 at 03:26:26PM +0200, Markus Armbruster wrote:
>> qemu_rbd_open() neglects to check pool and image are present.
>> Reproducer:
>> 
>>     $ qemu-system-x86_64 -nodefaults -drive if=none,driver=rbd,pool=p
>>     Segmentation fault (core dumped)
>
> This reproducer is wrong, I think.  Omitting the image should be caught
> earlier, but it is an error caught by the rbd_open() call.

Turns out the crash I observed was an artifact of my testing
instrumentation.

> What doesn't work is omitting the pool name, and that causes an abort()
> from rados_ioctx_create(), e.g.:
>
>
> $ qemu-system-x86_64 -nodefaults -drive driver=rbd,id=rbd,image=i,server.0.port=6789,server.0.host=192.168.15.180
> terminate called after throwing an instance of 'std::logic_error'
>   what():  basic_string::_M_construct null not valid
> Aborted (core dumped)
>
>
>>     $ qemu-system-x86_64 -nodefaults -drive if=none,driver=rbd,image=i
>>     qemu-system-x86_64: -drive if=none,driver=rbd,image=i: error opening pool (null)
>> 
>> Doesn't affect -drive with file=..., because qemu_rbd_parse_filename()
>> always sets both pool and image.
>> 
>> Doesn't affect -blockdev, because pool and image are mandatory in the
>> QAPI schema.
>> 
>> Fix by adding the missing checks.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> With an updated commit message:
>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

Thanks!
