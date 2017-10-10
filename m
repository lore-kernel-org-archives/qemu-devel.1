Received: from eggs.gnu.org ([2001:4830:134:3::10]:34945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=449ce4996=ross.lagerwall@citrix.com>)
	id 1e21zU-00075O-QY
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=449ce4996=ross.lagerwall@citrix.com>)
	id 1e21zR-0003nz-L6
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:23:04 -0400
Received: from smtp.citrix.com ([66.165.176.89]:7228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=449ce4996=ross.lagerwall@citrix.com>)
	id 1e21zR-0003lD-FB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:23:01 -0400
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<892cb484-361b-f1c1-c294-6b5d7b5e92fb@citrix.com>
	<56626155ee594136b8fe0d0de03ca4f5@AMSPEX02CL03.citrite.net>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <74e38d45-c173-4df1-c696-ca19cda41287@citrix.com>
Date: Tue, 10 Oct 2017 14:40:20 +0100
MIME-Version: 1.0
In-Reply-To: <56626155ee594136b8fe0d0de03ca4f5@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v2 0/*] xen: xen-domid-restrict
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, Ian Jackson <Ian.Jackson@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Juergen Gross <jgross@suse.com>

On 10/06/2017 02:19 PM, Paul Durrant wrote:
>> -----Original Message-----
>> From: Xen-devel [mailto:xen-devel-bounces@lists.xen.org] On Behalf Of
>> Ross Lagerwall
>> Sent: 06 October 2017 13:58
>> To: Ian Jackson <Ian.Jackson@citrix.com>; qemu-devel@nongnu.org
>> Cc: Anthony Perard <anthony.perard@citrix.com>; xen-
>> devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kernel.org>;
>> Juergen Gross <jgross@suse.com>
>> Subject: Re: [Xen-devel] [PATCH v2 0/*] xen: xen-domid-restrict
>> improvements
>>
>> On 10/04/2017 05:18 PM, Ian Jackson wrote:
>>> (Resending this because 1. I got the CC for xen-devel wrong; 2. I got
>>> the subject wrong: there are actually 8 patches; 3. I mangled
>>> Anthony's name in theheaders.  Sorry for the noise.)
>>>
>>> I have been working on trying to get qemu, when running as a Xen
>>> device model, to _actually_ not have power equivalent to root.
>>>
>>> I think I have achieved this, with some limitations (which will be
>>> discussed in my series against xen.git.
>>>
>>> However, there are changes to qemu needed.  In particular
>>>
>>>    * The -xen-domid-restrict option does not work properly right now.
>>>      It only restricts a small subset of the descriptors qemu has open.
>>>      I am introducing a new library call in the Xen libraries for this,
>>>      xentoolcore_restrict_all.
>>>
>>
>> Hi Ian,
>>
>> I'm testing your QEMU and Xen patch series and found that after being
>> restricted, QEMU fails to setup up the VGA memory properly which causes
>> a complete stall with stdvga. With cirrus it mostly works although it
>> seems to have reduced performance.
>>
>> I think it happens when the VM sets up the BAR some time after
>> xen_restrict() has been called. The failure comes from QEMU calling
>> xc_domain_add_to_physmap() which calls do_memory_op() and finally
>> xencall2(). But the underlying xencall fd has been replaced with /dev/null.
> 
> Oh, that's a PITA. This is because of the slightly hacky way that the VRAM is dealt with (it needing to be moved into the BAR of the PCI VGA device at the point where guest firmware programs it). Maybe we need a new dm_op for this?
> 
If no one objects, I propose adding the following calls to 
libxendevicemodel (with underlying Xen implementations, of course) that 
would be usable after the xendevicemodel handle has been restricted.

xendevicemodel_add_to_physmap(xendevicemodel_handle *dmod,
                               domid_t domid,
                               unsigned long idx,
                               xen_pfn_t gpfn);

This is equivalent to xc_domain_add_to_physmap() with
space==XENMAPSPACE_gmfn.

xendevicemodel_pin_memory_cacheattr(xendevicemodel_handle *dmod,
                                     domid_t domid,
                                     uint64_t start,
                                     uint64_t end,
                                     uint32_t type);

This is equivalent to xc_domain_pin_memory_cacheattr().

-- 
Ross Lagerwall
