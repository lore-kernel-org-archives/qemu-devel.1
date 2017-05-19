Received: from eggs.gnu.org ([2001:4830:134:3::10]:35640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dBgdo-0006gu-Kz
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dBgdk-0007B5-KK
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:04:20 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:55977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1dBgdk-0007Ar-BM
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:04:16 -0400
Message-Id: <591EFB5D020000780015B47A@prv-mh.provo.novell.com>
Date: Fri, 19 May 2017 06:04:13 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <1495085580-10631-1-git-send-email-tianyu.lan@intel.com>
	<1495085580-10631-2-git-send-email-tianyu.lan@intel.com>
	<20170519111622.GA3260@perard.uk.xensource.com>
In-Reply-To: <20170519111622.GA3260@perard.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [Xen-devel] [RFC PATCH V2 1/2] xen-pt: bind/unbind
 interrupt remapping format MSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>, Lan Tianyu <tianyu.lan@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, kevin.tian@intel.com, sstabellini@kernel.org, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, marcel@redhat.com, mst@redhat.com

>>> On 19.05.17 at 13:16, <anthony.perard@citrix.com> wrote:
> On Thu, May 18, 2017 at 01:32:59AM -0400, Lan Tianyu wrote:
>> --- a/include/hw/i386/apic-msidef.h
>> +++ b/include/hw/i386/apic-msidef.h
>> @@ -26,6 +26,7 @@
>> =20
>>  #define MSI_ADDR_DEST_ID_SHIFT          12
>>  #define MSI_ADDR_DEST_IDX_SHIFT         4
>> -#define  MSI_ADDR_DEST_ID_MASK          0x00ffff0
>> +#define  MSI_ADDR_DEST_ID_MASK          0x000fff00
>=20
> The value of MSI_ADDR_DEST_ID_MASK is changed here. I think the patch
> should be:
> +#define  MSI_ADDR_DEST_ID_MASK          0x000ffff0

Judging from other sources, rather the other way around - the
mask needs to have further bits removed (should be 0x000ff000
afaict). Xen sources confirm this, and while Linux has the value
you suggest, that contradicts

#define MSI_ADDR_DEST_ID_SHIFT		12
#define  MSI_ADDR_DEST_ID(dest)		(((dest) << MSI_ADDR_DEST_ID_SHIFT)=
 & \
					 MSI_ADDR_DEST_ID_MASK)

as well as

#define MSI_ADDR_EXT_DEST_ID(dest)	((dest) & 0xffffff00)

chopping off just the low 8 bits.

Jan
