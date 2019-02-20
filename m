Received: from eggs.gnu.org ([209.51.188.92]:41251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGQC-0005cx-Mw
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGPy-0004ov-7E
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:11:27 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:30 +0100
Message-Id: <20190220010232.18731-24-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 23/25] hw/ipmi: Assert outlen > outpos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

A througfull audit show that all time data is added to outbuf[],
'outlen' is incremented. Then at creation and each time
continue_send() returns it pass thru check_reset which resets
'outpos', thus we always have 'outlen >=3D outpos'.
Also due to the check on entry, we know outlen !=3D 0.
We can then add an assertion on 'outlen > outpos', which will
helps the next patch to safely convert 'outlen - outpos' as an
unsigned type (size_t).

Make this assertion explicit by casting 'outlen - outpos' size_t.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index bf0b7ee0f5..ca61b04942 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -107,8 +107,9 @@ static void continue_send(IPMIBmcExtern *ibe)
         goto check_reset;
     }
  send:
+    assert(ibe->outlen > ibe->outpos);
     ret =3D qemu_chr_fe_write(&ibe->chr, ibe->outbuf + ibe->outpos,
-                            ibe->outlen - ibe->outpos);
+                            (size_t)(ibe->outlen - ibe->outpos));
     if (ret > 0) {
         ibe->outpos +=3D ret;
     }
--=20
2.20.1
