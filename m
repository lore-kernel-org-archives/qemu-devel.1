Received: from eggs.gnu.org ([2001:4830:134:3::10]:39456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBmR-0005pO-Pp
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBmO-0003sw-KB
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:56:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHBmO-0003sM-AU
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:56:44 -0400
References: <20181026194314.18663-1-ppandit@redhat.com>
	<CAFEAcA8auV_NMER=nfrMnHOQ8oSSAupCt8ap2W+XJ4ypsR5uDA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b9136bd-47b8-4a39-59c1-5831498a2578@redhat.com>
Date: Mon, 29 Oct 2018 18:56:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8auV_NMER=nfrMnHOQ8oSSAupCt8ap2W+XJ4ypsR5uDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] lsi53c895a: check message length value
 is valid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Ameya More <ameya.more@oracle.com>

On 26/10/2018 22:55, Peter Maydell wrote:
>> +    assert(len <=3D LSI_MAX_MSGIN_LEN);
>>      pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
>>      /* Linux drivers rely on the last byte being in the SIDL.  */
>>      s->sidl =3D s->msg[len - 1];
> Is it possible to get here with len =3D=3D 0 ?

No, all calls to

    lsi_set_phase(s, PHASE_MI);

are followed or preceded by lsi_add_msg_byte.  But an assertion is good
to add.  What do you think of squashing this on top:

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 3a40e62853..72d85c42dd 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -865,9 +865,9 @@ static void lsi_do_msgin(LSIState *s)
     trace_lsi_do_msgin(s->dbc, s->msg_len);
     s->sfbr =3D s->msg[0];
     len =3D s->msg_len;
+    assert(len >=3D 0 && len <=3D LSI_MAX_MSGIN_LEN);
     if (len > s->dbc)
         len =3D s->dbc;
-    assert(len <=3D LSI_MAX_MSGIN_LEN);
     pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
     /* Linux drivers rely on the last byte being in the SIDL.  */
     s->sidl =3D s->msg[len - 1];
@@ -1706,8 +1706,10 @@
         break;
     case 0x58: /* SBDL */
         /* Some drivers peek at the data bus during the MSG IN phase.  *=
/
-        if ((s->sstat1 & PHASE_MASK) =3D=3D PHASE_MI)
+        if ((s->sstat1 & PHASE_MASK) =3D=3D PHASE_MI) {
+            assert(s->msg_len >=3D 0);
             return s->msg[0];
+        }
         ret =3D 0;
         break;
     case 0x59: /* SBDL high */


Paolo
