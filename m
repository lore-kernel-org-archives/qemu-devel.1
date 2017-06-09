Received: from eggs.gnu.org ([2001:4830:134:3::10]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dJGww-0006MS-If
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dJGwt-0006da-ED
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:15:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dJGwt-0006dU-91
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:15:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C402DC908
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 10:15:22 +0000 (UTC)
Date: Fri, 9 Jun 2017 06:15:21 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1764775958.32020420.1497003321879.JavaMail.zimbra@redhat.com>
In-Reply-To: <156294090.32020319.1497003113601.JavaMail.zimbra@redhat.com>
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-44-marcandre.lureau@redhat.com>
	<87h8zq1ikt.fsf@dusky.pond.sub.org>
	<156294090.32020319.1497003113601.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 43/43] qobject: move dump_qobject() from
 block/ to qobject/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi

----- Original Message -----
> > 
> > The title claims "move dump_qobject() from block/ to qobject/", but
> > that's not what the patch does.  It *replaces* dump_qobject() by
> > qobject_to_string().  The former dumps to a callback, the latter to a
> > dynamic string buffer.
> > 
> > Providing dump functionality in one way doesn't preclude the other way:
> > given callback, one could define a callback that builds up a string
> > buffer, and given buffer, one could (and you actually do) pass the
> > buffer to a callback.  That's less efficient, though.
> > 
> > Trading efficiency for ease-of-use should be okay here, but I'm cc'ing
> > Max and Kevin to double-check.
> 
> I believe convenience is more important than efficiency here. It's easy to
> call qobject_to_string(foo) from gdb for example, with a callback, it's less
> easy.
> 
> (fprintf or monitor_fprintf will both build an internal buffer anyway,
> efficiency is probably similar)
> 

Hmm, there are more allocations in qobject_to_string() though
