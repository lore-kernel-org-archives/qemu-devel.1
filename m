Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB7AC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8FA2468E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8FA2468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7IEL-0005Th-AK
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1j7IDS-0004qw-4P
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1j7IDP-0008Ro-EY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:24:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33088
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1j7IDP-0008Qz-9z
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:24:31 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01RCLfdD125360
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 07:24:30 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ydcnhhw35-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 07:24:30 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Thu, 27 Feb 2020 12:24:28 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 27 Feb 2020 12:24:25 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01RCNQea36176310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2020 12:23:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D22F52059;
 Thu, 27 Feb 2020 12:24:23 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.150])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4205252052;
 Thu, 27 Feb 2020 12:24:23 +0000 (GMT)
Date: Thu, 27 Feb 2020 13:24:02 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v5 07/18] s390x: protvirt: Inhibit balloon when
 switching to protected mode
In-Reply-To: <58a51f40-21c7-5737-4f4c-568fdd2477fa@linux.ibm.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-8-frankja@linux.ibm.com>
 <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
 <58a51f40-21c7-5737-4f4c-568fdd2477fa@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/I+Jzjdnch595BJeqmfEu3.+"; protocol="application/pgp-signature"
X-TM-AS-GCONF: 00
x-cbid: 20022712-0008-0000-0000-00000356F03E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022712-0009-0000-0000-00004A78122C
Message-Id: <20200227132402.67a38047.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-27_03:2020-02-26,
 2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270100
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/I+Jzjdnch595BJeqmfEu3.+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Feb 2020 16:11:03 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 2/26/20 3:59 PM, David Hildenbrand wrote:
> > On 26.02.20 13:20, Janosch Frank wrote:
> >> Ballooning in protected VMs can only be done when the guest shares the
> >> pages it gives to the host. Hence, until we have a solution for this
> >> in the guest kernel, we inhibit ballooning when switching into
> >> protected mode and reverse that once we move out of it.
> >=20
> > I don't understand what you mean here, sorry. zapping a page will mean
> > that a fresh one will be faulted in when accessed. And AFAIK, that means
> > it will be encrypted again when needed.
>=20
> Yes, as soon as the host alters non-shared memory we'll run into
> integrity issues.
>=20
>=20
> I've been talking to Halil after I sent this out and it looks like we'll
> rather try to automatically enable the IOMMU for all devices when
> switching into protected mode. He said that if the IOMMU is set the
> balloon code will do an early exit on feature negotiation.
>=20

I have a discussion starter RFC for you.

--------------------------8<----------------------------------------------
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 26 Feb 2020 16:48:21 +0100
Subject: [RFC PATCH 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM

The virtio specification tells that the device is to present
VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
device "can only access certain memory addresses with said access
specified and/or granted by the platform". This is the case for a
protected VM, as the device can access only memory addresses that are in
pages that are currently shared (only the guest can share/unsare its
page).

No VM however starts out as a protected VM, but some VMs may be
converted to protected VMs if the guest decides so.

Making the end user explicitly manage the VIRTIO_F_ACCESS_PLATFORM via
the property iommu_on is a minor disaster. If the correctness of the
paravirtualized virtio devices depends (and thus in a sense the
correctness of the hypervisor), then the hypervisor should have the last
word about whether VIRTIO_F_ACCESS_PLATFORM is to be presented or not.

Let's manage the VIRTIO_F_ACCESS_PLATFORM virtio feature automatically
for virtio-ccw devices, so that we set it before we start the protected
configuration, and unset it when our VM is not protected.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
NOTES:
* I wanted to have a discussion starter fast, there are multiple open
questions.

* Doing more than one system_resets() is hackish.  We
should look into this.

* The user interface implications of this patch are also an ugly can of
worms. Needs to be discussed.

* We should consider keeping the original value if !pv and restoring it
on pv --> !pv, instead of forcing to unset when leaving pv, and actually
not forcing unset when !pv.

* It might make sense to do something like this in virtio core, but I
  decided start the discussion with a ccw-only change.

* Maybe we need a machine option that enables this sort of behavior,
especially if we decide not to do the conserving/restoring.

* Lightly tested.
---
 hw/s390x/s390-virtio-ccw.c |  4 ++--
 hw/s390x/virtio-ccw.c      | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 0f4455d1df..996124f152 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -337,7 +337,7 @@ static void s390_machine_unprotect(S390CcwMachineState =
*ms)
         ms->pv =3D false;
     }
     migrate_del_blocker(pv_mig_blocker);
-    qemu_balloon_inhibit(false);
+    subsystem_reset();
 }
=20
 static int s390_machine_protect(S390CcwMachineState *ms)
@@ -346,7 +346,6 @@ static int s390_machine_protect(S390CcwMachineState *ms)
     CPUState *t;
     int rc;
=20
-    qemu_balloon_inhibit(true);
     if (!pv_mig_blocker) {
         error_setg(&pv_mig_blocker,
                    "protected VMs are currently not migrateable.");
@@ -384,6 +383,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
     if (rc) {
         goto out_err;
     }
+    subsystem_reset();
     return rc;
=20
 out_err:
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 13f57e7b67..48bb54f68e 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -869,12 +869,24 @@ static void virtio_ccw_notify(DeviceState *d, uint16_=
t vector)
     }
 }
=20
+static inline void virtio_ccw_pv_enforce_features(VirtIODevice *vdev)
+{
+    S390CcwMachineState *ms =3D S390_CCW_MACHINE(qdev_get_machine());
+
+    if (ms->pv) {
+        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
+    } else {
+        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM=
);
+    }
+}
+
 static void virtio_ccw_reset(DeviceState *d)
 {
     VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);
     VirtIODevice *vdev =3D virtio_bus_get_device(&dev->bus);
     VirtIOCCWDeviceClass *vdc =3D VIRTIO_CCW_DEVICE_GET_CLASS(dev);
=20
+    virtio_ccw_pv_enforce_features(vdev);
     virtio_ccw_reset_virtio(dev, vdev);
     if (vdc->parent_reset) {
         vdc->parent_reset(d);
@@ -1103,6 +1115,7 @@ static void virtio_ccw_pre_plugged(DeviceState *d, Er=
ror **errp)
     if (dev->max_rev >=3D 1) {
         virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
     }
+    virtio_ccw_pv_enforce_features(vdev);
 }
=20
 /* This is called by virtio-bus just after the device is plugged. */

base-commit: 8665f2475f5999d4c9f33598f1360f0b0797c489
--=20
2.17.1


--Sig_/I+Jzjdnch595BJeqmfEu3.+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJeV7T1AAoJEA0vhuyXGx0AhaUQAMa4nQ75m3YKptEDO+FVkQPA
cEFdGodMIZtzO3zWpZ30J1wnMWKFrIWCavyPF1Cgu+xp9kTy8U0dX0TV30vS0QEt
NeeVO3gj9YJwSKA80MqN47qpsA10r2zh+a7cT8g3ZnPyAgQmEeNFmufZEzbJIzN1
A7STcXx/0uPX17uUMZCwwNzxgzOCwOf4Y2h4orBIAnwO8fIRrYn8mrHQSRhUhpaV
Gjczm1Y/8Z7JO+kVOilfwBUjDNzuGLe4eFBDO8IXYtLc3kDb8rR6UqZd0cjQYNmA
/zZmddkcOrEeA7sMEvX7pZpc2C3JAMfwFccHYGTpjoHqdVc/zsyfWKUdnCWP3Cuh
0E5m5WVNBQG/r+btXTIhAYCPusCikLiigx0ofTt3phLe2O+f89AuFUdbr7xOlBcC
DNZRgl6Ns6t0tf+laB3Z5cR3M8T2A+DgPn3k8EFt62bj/npMQ6pan3XNCXuE4j/2
VJ2KupuTGoGHna9aO3mJ07vKzCBk+XozjT6hc0f7AwqbkQHuueSToRCcgRb+6rsX
ucILESzWo3mPkrlqQeaqvVrpFEOw8NdmXyBlPlI+bKLAfyMIdS83MsXOEh2zyPxT
FktecG2Zf0Op7ZTo5g02UCHY7OaOrj+8IkUPV+ktRgzLvxNv/hMn6OFFQG4Vl1A6
DtOTlWaaPv0MwhrBSVy0
=jQPO
-----END PGP SIGNATURE-----

--Sig_/I+Jzjdnch595BJeqmfEu3.+--


