Received: from eggs.gnu.org ([2001:4830:134:3::10]:51436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnjTj-0000aG-Ic
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnjTi-0002ky-PN
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:14:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnjTi-0002kp-JF
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:14:54 -0400
References: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
	<1489158897-9206-2-git-send-email-yang.zhong@intel.com>
	<53522014-8f70-9358-7d60-8b6c491c9611@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A0F91A@ORSMSX112.amr.corp.intel.com>
	<920352018.1797331.1489251855464.JavaMail.zimbra@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A13045@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <991a0f3d-5e1f-d17c-a8f3-a42c02ac2f17@redhat.com>
Date: Tue, 14 Mar 2017 11:14:51 +0100
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A13045@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/2] reduce qemu's heap Rss size from
 12252kB to 2752KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: "Zhong, Yang" <yang.zhong@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng, Chao P" <chao.p.peng@intel.com>



On 14/03/2017 06:14, Xu, Anthony wrote:
> Below functions are registered in RCU thread
> address_space_dispatch_free,
> do_address_space_destroy
> flatview_unref
> reclaim_ramblock,
> qht_map_destroy,
> migration_bitmap_free
>=20
> first three are address space related, should work without global lock =
per above analysis.
> The rest are very simple, seems doesn't need global lock.

flatview_unref can call object_unref and thus reach:

- all QOM instance_finalize callbacks

- all QOM property release callbacks

In turn, of QOM property release callbacks the more important ones are
release_drive (which calls blockdev_auto_del and blk_detach_dev) and
release_chr (which calls qemu_chr_fe_deinit).

Your patch is incorrect, sorry.  If it were that simple, it would have
been done already...

Paolo
