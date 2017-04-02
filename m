Received: from eggs.gnu.org ([2001:4830:134:3::10]:41916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cuffC-0000cZ-PF
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 09:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cuff9-0007HH-N3
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 09:35:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cuff9-0007FX-Hk
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 09:35:23 -0400
Date: Sun, 2 Apr 2017 10:31:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170402133153.GA1910@thinpad.lan.raisama.net>
References: <20170329194148.19015-1-ehabkost@redhat.com>
	<afd04dba-4ebd-24a7-d149-2e6f079c2868@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afd04dba-4ebd-24a7-d149-2e6f079c2868@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Juergen Gross <jgross@suse.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Laszlo Ersek <lersek@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Thu, Mar 30, 2017 at 10:59:10AM +0200, Paolo Bonzini wrote:
[...]
> That said, the QUALIFIED_CAST concept is very interesting and I'd even
> extend it to OBJECT_CHECK, object_dynamic_cast and
> object_dynamic_cast_assert.  I'm just not sure about returning const
> from object_get_class()/*_GET_CLASS, which ironically is the thing that
> prompted you to write the series. :)

When trying to change OBJECT and OBJECT_CHECK, I've found a
problem: gcc 6.2.1 can't evaluate typeof(*a) if *a has an
incomplete type, even inside the (const typeof(*(t)0) *)
expression used in QUALIFIED_CAST. It works on clang, though.

I'm not sure we want to introduce something that would report
errors only on clang only[1]. Especially when the error messages
look like this:
  hw/mem/pc-dimm.c:248:23: error: passing 'typeof (_Generic((const typeof (*((typeof ((a)))0)) *)0, typeof ((a)): (const Object *)(0), default: (Object *)(0)))' (aka 'const struct Object *') to parameter of type 'Object *' (aka 'struct Object *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
      PCDIMMDevice *x = PC_DIMM(a);

Lucikly all the OBJECT_CLASS usage I've found never involved
incomplete types, but they are more common when dealing with
object pointers.

We could also require all users of OBJECT(x) to include the
header that defines the struct type of x. But I'm not sure it's
worth the effort.

-- 
Eduardo
