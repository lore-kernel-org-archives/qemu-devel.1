Received: from eggs.gnu.org ([2001:4830:134:3::10]:47612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctVvN-0005UI-Qn
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 04:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctVvI-0005Ih-Td
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 04:59:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ctVvI-0005Hb-Nw
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 04:59:16 -0400
References: <20170329194148.19015-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <afd04dba-4ebd-24a7-d149-2e6f079c2868@redhat.com>
Date: Thu, 30 Mar 2017 10:59:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170329194148.19015-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Juergen Gross <jgross@suse.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Laszlo Ersek <lersek@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>



On 29/03/2017 21:41, Eduardo Habkost wrote:
> QOM has a data model where class struct data is static: class
> structs are initialized at class_init, and never changed again.

Isn't that just the way class data is being used?  There's no reason for
class data to be static.  It happens to be that way because our
hierarchies are pretty shallow and global static variables are used
instead of class data.  But it doesn't _have_ to be like that.

That said, the QUALIFIED_CAST concept is very interesting and I'd even
extend it to OBJECT_CHECK, object_dynamic_cast and
object_dynamic_cast_assert.  I'm just not sure about returning const
from object_get_class()/*_GET_CLASS, which ironically is the thing that
prompted you to write the series. :)

Paolo

> ...except for a few rare cases where class data is changed
> outside class_init. Those cases are:
>=20
>   qbus_realize(), code added by:
>   commit 61de36761b565a4138d8ad7ec75489ab28fe84b6
>   Date:   Thu Feb 6 16:08:15 2014 +0100
>       qdev: Keep global allocation counter per bus
>=20
>   mips_jazz_init(), code added by:
>   commit 54e755588cf1e90f0b1460c4e8e6b6a54b6d3a32
>   Date:   Mon Nov 4 23:26:17 2013 +0100
>       mips jazz: do not raise data bus exception when accessing invalid=
 addresses
>=20
>   xen_set_dynamic_sysbus(), code added by:
>   commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894
>   Date:   Tue Nov 22 07:10:58 2016 +0100
>       xen: create qdev for each backend device
>=20
>   s390_cpu_realizefn(), code added by:
>   commit c6644fc88bed1176f67b4b7a9df691bcf25c0c5b
>   Date:   Fri Mar 4 12:34:31 2016 -0500
>       s390x/cpu: Get rid of side effects when creating a vcpu
