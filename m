Received: from eggs.gnu.org ([2001:4830:134:3::10]:47586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d04hA-0005tm-Uh
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d04h5-0002yQ-Vz
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:19:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d04h5-0002y5-RI
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:19:43 -0400
Date: Mon, 17 Apr 2017 19:19:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170417111936.GF16703@pxdev.xzpeter.org>
References: <CADUDsAo4-QypkwSR9p8ABpBRqtvCO886fec2BGdq1JtgCgt-6w@mail.gmail.com>
	<20170417102607.GE16703@pxdev.xzpeter.org>
	<CADUDsAqnRJDhYcu2nR-zk5fkJDQ8GKkR7GjO-MrAEiJTt_X+oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADUDsAqnRJDhYcu2nR-zk5fkJDQ8GKkR7GjO-MrAEiJTt_X+oA@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu memory manage question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "jack.chen" <zhunxun@gmail.com>
Cc: qemu <qemu-devel@nongnu.org>

On Mon, Apr 17, 2017 at 06:55:40PM +0800, jack.chen wrote:
> Thanks,from the path you have list to me,it can be  well explained,but
> according to the source code,in the end of
> kvm_init,kvm_memory_listener and  kvm_io_listener were registered by
> memory_listener_register(),and  in the end of
> memory_listener_register(),listener_add_address_space() was called for
> each address_space,so the listener->region_add was executed then.I do
> not know what mistake I have made,can you explain it to me ?? thank
> you very much!

Firstly, there are two address spaces for each system:

AddressSpace address_space_io;
AddressSpace address_space_memory;

The one you mentioned (kvm_io_listener) should be the listener for
address_space_io, not address_space_memory, while for RAM, it's
located on address_space_memory space.

Secondly, when calling memory_listener_register() in kvm_init(),
region_add() is actually not called, since FOR_EACH_FLAT_RANGE() in
listener_add_address_space() is actually looping nothing since at that
time the address_space_memory may not ever been rendered at all
(rendering should be triggered by memory_region_transaction_commit()
-> address_space_update_topology()).

Thanks,

-- 
Peter Xu
