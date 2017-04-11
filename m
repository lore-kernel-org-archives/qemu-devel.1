Received: from eggs.gnu.org ([2001:4830:134:3::10]:54248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hrgstephen@gmail.com>) id 1cxniE-0001qk-0o
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 00:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hrgstephen@gmail.com>) id 1cxniD-0004wf-5y
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 00:47:30 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:33866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hrgstephen@gmail.com>)
	id 1cxniD-0004vv-1R
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 00:47:29 -0400
Received: by mail-ua0-x243.google.com with SMTP id u59so7446674uau.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 21:47:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1704101243270.2759@sstabellini-ThinkPad-X260>
References: <CADZi59zNxk-Yr4rpN1E49s=AdsdW-W9YfhpCvpJeBz7oigyFSg@mail.gmail.com>
	<CADZi59xe6OcCasvtkPBjP7nTsgDA5r_E_Rt7W88BszYdJhuxGQ@mail.gmail.com>
	<CADZi59xEg0SvScgo=Jg0MxTbGYY=nTX18Qo-4GMkfayThDU9zw@mail.gmail.com>
	<alpine.DEB.2.10.1704101159340.2759@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1704101243270.2759@sstabellini-ThinkPad-X260>
From: hrg <hrgstephen@gmail.com>
Date: Tue, 11 Apr 2017 12:47:26 +0800
Message-ID: <CADZi59yC4m+wFS+iJUrV9Y59X96cQVMnrCNLvcd5o2kdjmqQdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC/BUG] xen-mapcache: buggy invalidate map cache?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xensource.com, qemu-devel@nongnu.org, Jun Nakajima <jun.nakajima@intel.com>, Alexander Graf <agraf@suse.de>, xen-devel@lists.xenproject.org, xen-devel@lists.xen.org, "Herongguang (Stephen)" <herongguang.he@huawei.com>, wangxinxin.wang@huawei.com

On Tue, Apr 11, 2017 at 3:50 AM, Stefano Stabellini
<sstabellini@kernel.org> wrote:
> On Mon, 10 Apr 2017, Stefano Stabellini wrote:
>> On Mon, 10 Apr 2017, hrg wrote:
>> > On Sun, Apr 9, 2017 at 11:55 PM, hrg <hrgstephen@gmail.com> wrote:
>> > > On Sun, Apr 9, 2017 at 11:52 PM, hrg <hrgstephen@gmail.com> wrote:
>> > >> Hi,
>> > >>
>> > >> In xen_map_cache_unlocked(), map to guest memory maybe in entry->ne=
xt
>> > >> instead of first level entry (if map to rom other than guest memory
>> > >> comes first), while in xen_invalidate_map_cache(), when VM balloone=
d
>> > >> out memory, qemu did not invalidate cache entries in linked
>> > >> list(entry->next), so when VM balloon back in memory, gfns probably
>> > >> mapped to different mfns, thus if guest asks device to DMA to these
>> > >> GPA, qemu may DMA to stale MFNs.
>> > >>
>> > >> So I think in xen_invalidate_map_cache() linked lists should also b=
e
>> > >> checked and invalidated.
>> > >>
>> > >> What=E2=80=99s your opinion? Is this a bug? Is my analyze correct?
>>
>> Yes, you are right. We need to go through the list for each element of
>> the array in xen_invalidate_map_cache. Can you come up with a patch?
>
> I spoke too soon. In the regular case there should be no locked mappings
> when xen_invalidate_map_cache is called (see the DPRINTF warning at the
> beginning of the functions). Without locked mappings, there should never
> be more than one element in each list (see xen_map_cache_unlocked:
> entry->lock =3D=3D true is a necessary condition to append a new entry to
> the list, otherwise it is just remapped).
>
> Can you confirm that what you are seeing are locked mappings
> when xen_invalidate_map_cache is called? To find out, enable the DPRINTK
> by turning it into a printf or by defininig MAPCACHE_DEBUG.

In fact, I think the DPRINTF above is incorrect too. In
pci_add_option_rom(), rtl8139 rom is locked mapped in
pci_add_option_rom->memory_region_get_ram_ptr (after
memory_region_init_ram). So actually I think we should remove the
DPRINTF warning as it is normal.
