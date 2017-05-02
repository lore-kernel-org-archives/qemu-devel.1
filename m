Received: from eggs.gnu.org ([2001:4830:134:3::10]:45113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5a8a-0003UP-Lw
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5a8X-0002N9-Ke
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:54:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d5a8X-0002MI-Ds
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:54:49 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59FAFBF2C4
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 15:54:48 +0000 (UTC)
References: <20170502083500.GA27432@redhat.com>
	<87y3ufjpsr.fsf@dusky.pond.sub.org> <20170502145913.GF16511@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86128a38-af03-5ee1-7de6-124384e3d2a2@redhat.com>
Date: Tue, 2 May 2017 17:54:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170502145913.GF16511@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: "Richard W.M. Jones" <rjones@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: QEMU Development <qemu-devel@nongnu.org>



On 02/05/2017 16:59, Richard W.M. Jones wrote:
>> To answer your question: you have to double comma after '=', or else it
>> terminates the value.  There is no other quoting.
>
> Hmm, is that really right?  It seems to me that any comma must be
> doubled.  For example:
> 
> $ qemu-system-x86_64 -name foo,bar -writeconfig - -hda die
> qemu-system-x86_64: -name foo,bar: Invalid parameter 'bar'

That's because, as you found out, "-name" is not a simple option but a
compound one; "-name foo" is short for "-name guest=foo" (compare
"-device e1000").

The grammar mentioned in util/keyval.c says that you have to double
comma in a value, *and* comma is completely invalid in a key.

If you have '=', you have to double commas after it and cannot use it
before.

If you have no '=' at all, then you have to double comma too.

Paolo

> $ qemu-system-x86_64 -name foo,,bar -writeconfig - -hda die
> # qemu config file
> 
> [name]
>   guest = "foo,bar"
