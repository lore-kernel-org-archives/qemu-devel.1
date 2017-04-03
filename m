Received: from eggs.gnu.org ([2001:4830:134:3::10]:38022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cuyXN-0002y2-0D
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cuyXI-0000Wm-1g
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:44:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cuyXH-0000WE-Rk
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:44:31 -0400
References: <20170329194148.19015-1-ehabkost@redhat.com>
	<afd04dba-4ebd-24a7-d149-2e6f079c2868@redhat.com>
	<20170402133153.GA1910@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97f00822-e8f8-cd25-7e8f-33522d4d4834@redhat.com>
Date: Mon, 3 Apr 2017 11:44:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170402133153.GA1910@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 0/9] qom: Make
 object_get_class()/*_GET_CLASS return const pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Juergen Gross <jgross@suse.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Laszlo Ersek <lersek@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>



On 02/04/2017 15:31, Eduardo Habkost wrote:
> When trying to change OBJECT and OBJECT_CHECK, I've found a
> problem: gcc 6.2.1 can't evaluate typeof(*a) if *a has an
> incomplete type, even inside the (const typeof(*(t)0) *)
> expression used in QUALIFIED_CAST. It works on clang, though.
> 
> I'm not sure we want to introduce something that would report
> errors only on clang only[1]. Especially when the error messages
> look like this:
>   hw/mem/pc-dimm.c:248:23: error: passing 'typeof (_Generic((const typeof (*((typeof ((a)))0)) *)0, typeof ((a)): (const Object *)(0), default: (Object *)(0)))' (aka 'const struct Object *') to parameter of type 'Object *' (aka 'struct Object *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>       PCDIMMDevice *x = PC_DIMM(a);
> 
> Lucikly all the OBJECT_CLASS usage I've found never involved
> incomplete types, but they are more common when dealing with
> object pointers.
> 
> We could also require all users of OBJECT(x) to include the
> header that defines the struct type of x. But I'm not sure it's
> worth the effort.

Fair enough!  Thanks for trying.

Paolo
