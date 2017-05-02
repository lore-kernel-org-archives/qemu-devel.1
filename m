Received: from eggs.gnu.org ([2001:4830:134:3::10]:32881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5aoI-00050K-Ji
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5aoH-0001HS-Md
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d5aoH-0001Fh-Gl
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70283C2A5BE9
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 16:37:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170502083500.GA27432@redhat.com>
	<87y3ufjpsr.fsf@dusky.pond.sub.org>
	<20170502145913.GF16511@redhat.com>
	<86128a38-af03-5ee1-7de6-124384e3d2a2@redhat.com>
Date: Tue, 02 May 2017 18:37:54 +0200
In-Reply-To: <86128a38-af03-5ee1-7de6-124384e3d2a2@redhat.com> (Paolo
	Bonzini's message of "Tue, 2 May 2017 17:54:44 +0200")
Message-ID: <871ss7cizh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Writing a C library to generate qemu command lines
 and configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, QEMU Development <qemu-devel@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 02/05/2017 16:59, Richard W.M. Jones wrote:
>>> To answer your question: you have to double comma after '=', or else it
>>> terminates the value.  There is no other quoting.
>>
>> Hmm, is that really right?

I should avoid absolutes when it comes to QemuOpts...

>>                             It seems to me that any comma must be
>> doubled.  For example:
>> 
>> $ qemu-system-x86_64 -name foo,bar -writeconfig - -hda die
>> qemu-system-x86_64: -name foo,bar: Invalid parameter 'bar'
>
> That's because, as you found out, "-name" is not a simple option but a
> compound one; "-name foo" is short for "-name guest=foo" (compare
> "-device e1000").
>
> The grammar mentioned in util/keyval.c says that you have to double
> comma in a value, *and* comma is completely invalid in a key.
>
> If you have '=', you have to double commas after it and cannot use it
> before.
>
> If you have no '=' at all, then you have to double comma too.

Yes.  My description wasn't precise enough, sorry.

Please take note that the grammar in util/keyval.c does *not* produce
the exact QemuOpts language.  It's close, but it doesn't reproduce all
corner cases.  Anything it does produce should have the same meaning in
QemuOpts.

> Paolo
>
>> $ qemu-system-x86_64 -name foo,,bar -writeconfig - -hda die
>> # qemu config file
>> 
>> [name]
>>   guest = "foo,bar"
