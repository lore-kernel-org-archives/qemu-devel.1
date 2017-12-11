Received: from eggs.gnu.org ([2001:4830:134:3::10]:59684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eOZWP-0008SS-HO
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eOZWL-0004IB-KE
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:38:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:28783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.gao@intel.com>) id 1eOZWL-0004H9-As
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:38:09 -0500
Date: Tue, 12 Dec 2017 02:35:16 +0800
From: Chao Gao <chao.gao@intel.com>
Message-ID: <20171211183516.GB18476@op-computing>
References: <1510899865-40323-1-git-send-email-chao.gao@intel.com>
	<1510899865-40323-4-git-send-email-chao.gao@intel.com>
	<20171211180748.GD2216@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211180748.GD2216@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] msi: Handle remappable format
 interrupt request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Lan Tianyu <tianyu.lan@intel.com>

On Mon, Dec 11, 2017 at 06:07:48PM +0000, Anthony PERARD wrote:
>On Fri, Nov 17, 2017 at 02:24:25PM +0800, Chao Gao wrote:
>> According to VT-d spec Interrupt Remapping and Interrupt Posting ->
>> Interrupt Remapping -> Interrupt Request Formats On Intel 64
>> Platforms, fields of MSI data register have changed. This patch
>> avoids wrongly regarding a remappable format interrupt request as
>> an interrupt binded with a pirq.
>> 
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>> v3:
>>  - clarify the interrupt format bit is Intel-specific, then it is
>>  improper to define MSI_ADDR_IF_MASK in a common header.
>> ---
>>  hw/i386/xen/xen-hvm.c | 10 +++++++++-
>>  hw/pci/msi.c          |  5 +++--
>>  hw/pci/msix.c         |  4 +++-
>>  hw/xen/xen_pt_msi.c   |  2 +-
>>  include/hw/xen/xen.h  |  2 +-
>>  stubs/xen-hvm.c       |  2 +-
>>  6 files changed, 18 insertions(+), 7 deletions(-)
>> 
>> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>> index 8028bed..52dc8af 100644
>> --- a/hw/i386/xen/xen-hvm.c
>> +++ b/hw/i386/xen/xen-hvm.c
>> @@ -145,8 +145,16 @@ void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
>>      }
>>  }
>>  
>> -int xen_is_pirq_msi(uint32_t msi_data)
>> +int xen_is_pirq_msi(uint32_t msi_addr_lo, uint32_t msi_data)
>>  {
>> +    /* If the MSI address is configured in remapping format, the MSI will not
>> +     * be remapped into a pirq. This 'if' test excludes Intel-specific
>> +     * remappable msi.
>> +     */
>> +#define MSI_ADDR_IF_MASK 0x00000010
>
>I don't think that is the right place for a define, they also exist
>outside of the context of the function.

yes.

>That define would be better at the top of this file, I think.(There is

will do.

Thanks
Chao

>probably a better place in the common headers, but I'm not sure were.)
