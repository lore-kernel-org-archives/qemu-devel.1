Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B5C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0C02072D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k3S9n80W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0C02072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeMjH-0002x5-OX
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jeMiW-00027D-DG; Thu, 28 May 2020 13:53:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jeMiU-0004zz-Km; Thu, 28 May 2020 13:53:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04SHW0cZ193907; Thu, 28 May 2020 13:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=9oj3Be8hW8yN/B2cMToHQyO1OpeRFuzuLBK3wZqm4Kc=;
 b=k3S9n80WvEOSSxszjVm8yipdt7GMMTUxnRkLfoio6P51AxDn/FAOgmEtvsFCFOL8nO7r
 jgAwgf4Z1TyijJCqtcsii1U/JQM+rQpugg7QFh5SzboKe16KUJueIyQn0BXwYcSaNf/P
 fclO6Q1xfxqAXrUp8QR0DqEkr5dfMNbEEmJvfvMtL4LBVyRJjNXzpXm30KqwnW+kw5j4
 dMgoch7+siDqWXPnQBZ91rASbZVONN8viCr/7Lml83/ZXTOarXjKJIKs0cGk0fRKcrd8
 NTAXorkxS+ef1nO6H/w7YILVT8HNhyn6FUgGqzDgogrAOplA06OdN826TF+tpI6BegMy ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 319xxskesr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2020 13:53:14 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04SHg3Qd036004;
 Thu, 28 May 2020 13:53:13 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 319xxskerw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2020 13:53:13 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04SHZPuK006545;
 Thu, 28 May 2020 17:53:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03ams.nl.ibm.com with ESMTP id 316uf8ac85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2020 17:53:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 04SHr8QT61014368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2020 17:53:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E23B5204E;
 Thu, 28 May 2020 17:53:08 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.21.214])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BB61E5204F;
 Thu, 28 May 2020 17:53:07 +0000 (GMT)
Date: Thu, 28 May 2020 19:52:51 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200528195251.3f17a70e.pasic@linux.ibm.com>
In-Reply-To: <20200528132112.2a1fdf45.cohuck@redhat.com>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200522230451.632a3787.pasic@linux.ibm.com>
 <20200528132112.2a1fdf45.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-28_03:2020-05-28,
 2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0
 cotscore=-2147483648 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 13:53:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 13:21:12 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 22 May 2020 23:04:51 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
>=20
> > On Wed, 20 May 2020 12:23:24 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
[..]
> > > So, how about this: switch iommu to on/off/auto. =20
> >=20
> > Many thanks for the reveiw, and sorry about the delay on my side. We
> > have holidays here in Germany and I was not motivated enough up until
> > now to check on my mails.
> >=20
> >=20
> > I've actually played  with the thought of switching iommu_platform to=20
> > 'on/off/auto', but I didn't find an easy way to do it. I will look
> > again. This would be the first property of this kind in QEMU, or?
>=20
> virtio-pci uses it for 'disable-legacy'.
>=20

Thank you very much! This makes tinging about 'on/off/auto' much easier.

> >=20
> > The 'on/off/auto' would be certainly much cleaner form user-interface
> > perspective. The downsides are that it is more invasive, and more
> > complicated. I'm afraid that it would also leave more possibilities for
> > user error.
>=20
> To me, on/off/auto sounds like a reasonable thing to do.
>=20
> What possibilities of 'user error' do you see?=20

I will whip up a prototype first and then come back to you with more
details.

The short answer is if the user isn't very careful about all the whistles
and bells, I understand that the user will end up with a partially or
fully non-PV-compatible VM.

I had an internal bugreport where there was a nic generated by default
that of course did not have iommu_platform=3D'on'.



> Shouldn't we fence off
> misconfigurations, if the consequences would be disastrous?
>=20

I fully agree! This is unfortunately currently not the case. My patch
takes the approach of avoiding miss-configuration in the first place,
instead of sapping the user for it.

> >=20
> > >  Add a property with a
> > > reasonable name "allow protected"?  If set allow switch to protected
> > > memory and also set iommu auto to on by default.  If not set then don=
't.
> > > =20
> >=20
> > I think we have "allow protected" already expressed via cpu models. I'm
> > also not sure how libvirt would react to the idea of a new machine
> > property for this. You did mean "allow protected" as machine property,
> > or?
>=20
> "Unpack facility in cpu model" means "guest may transition into pv
> mode", right? What does it look like when the guest actually has
> transitioned?

Janosch has answered these. Will add my thoughts there.

>=20
> >=20
> > AFAIU "allow protected" would be required for the !PV to PV switch, and
> > we would have to reject paravirtualized devices with iommu_platform=3D'=
off'
> > on VM construction or hotplug (iommu_platform=3D'auto/on' would be fine=
).
> >=20
> > Could you please confirm that I understood this correctly?
> >=20
> >=20
> > > This will come handy for other things like migrating to hosts without
> > > protected memory support.
> > >  =20
> >=20
> > This is already covered by cpu model AFAIK.
>=20
> I don't think we'd want to migrate between pv and non-pv anyway?
>=20

ditto

[..]
> > >=20
> > > I don't really understand things fully but it looks like you are
> > > changing features of a device.  If so this bothers me, resets
> > > happen at random times while driver is active, and we never
> > > expect features to change.
> > > =20
> >=20
> > Changing the device features is IMHO all right because the features can
> > change only immediately after a system reset and before the first vCPU
> > is run. That is ensured by two facts.
> >=20
> >=20
> > First, the feature can only change when ms->pv changes. That is on the
> > first reset after the VM entered or left the "protected virtualization"
> > mode of operation. And that switch requires a system reset. Because the
> > PV switch is initiated by the guest, and the guest is rebooted as a
> > consequence, the guest will never observe the change in features.
>=20
> This really needs more comments, as it is not obvious to the casual
> reader. (I also stumbled over the resets.)

Sorry, where exactly would you like to have those extra comments?

>=20
> But I wonder whether we are actually missing those subsystems resets
> today?
>=20

If I have to settle for yes or no, my answer is no.

We need at least one subsystem reset during the conversion. Without
my patch applied things look like this

$ git grep -p -B 5 -e subsystem_reset HEAD~1 -- hw/s390x/s390-virtio-ccw.c
HEAD~1:hw/s390x/s390-virtio-ccw.c=3Dstatic const char *const reset_dev_type=
s[] =3D {
--
HEAD~1:hw/s390x/s390-virtio-ccw.c-    "s390-sclp-event-facility",
HEAD~1:hw/s390x/s390-virtio-ccw.c-    "s390-flic",
HEAD~1:hw/s390x/s390-virtio-ccw.c-    "diag288",
HEAD~1:hw/s390x/s390-virtio-ccw.c-};
HEAD~1:hw/s390x/s390-virtio-ccw.c-
HEAD~1:hw/s390x/s390-virtio-ccw.c:static void subsystem_reset(void)
--
HEAD~1:hw/s390x/s390-virtio-ccw.c=3Dstatic void s390_machine_reset(MachineS=
tate *machine)
--
HEAD~1:hw/s390x/s390-virtio-ccw.c-    case S390_RESET_MODIFIED_CLEAR:
HEAD~1:hw/s390x/s390-virtio-ccw.c-        /*
HEAD~1:hw/s390x/s390-virtio-ccw.c-         * Susbsystem reset needs to be d=
one before we unshare memory
HEAD~1:hw/s390x/s390-virtio-ccw.c-         * and lose access to VIRTIO stru=
ctures in guest memory.
HEAD~1:hw/s390x/s390-virtio-ccw.c-         */
HEAD~1:hw/s390x/s390-virtio-ccw.c:        subsystem_reset();
--
HEAD~1:hw/s390x/s390-virtio-ccw.c-    case S390_RESET_LOAD_NORMAL:
HEAD~1:hw/s390x/s390-virtio-ccw.c-        /*
HEAD~1:hw/s390x/s390-virtio-ccw.c-         * Susbsystem reset needs to be d=
one before we unshare memory
HEAD~1:hw/s390x/s390-virtio-ccw.c-         * and lose access to VIRTIO stru=
ctures in guest memory.
HEAD~1:hw/s390x/s390-virtio-ccw.c-         */
HEAD~1:hw/s390x/s390-virtio-ccw.c:        subsystem_reset();
--
HEAD~1:hw/s390x/s390-virtio-ccw.c-        }
HEAD~1:hw/s390x/s390-virtio-ccw.c-        run_on_cpu(cs, s390_do_cpu_initia=
l_reset, RUN_ON_CPU_NULL);
HEAD~1:hw/s390x/s390-virtio-ccw.c-        run_on_cpu(cs, s390_do_cpu_load_n=
ormal, RUN_ON_CPU_NULL);
HEAD~1:hw/s390x/s390-virtio-ccw.c-        break;
HEAD~1:hw/s390x/s390-virtio-ccw.c-    case S390_RESET_PV: /* Subcode 10 */
HEAD~1:hw/s390x/s390-virtio-ccw.c:        subsystem_reset();

That is except for=20
hw/s390x/s390-virtio-ccw.c-    case S390_RESET_EXTERNAL:
hw/s390x/s390-virtio-ccw.c-    case S390_RESET_REIPL:
hw/s390x/s390-virtio-ccw.c-        if (s390_is_pv()) {
hw/s390x/s390-virtio-ccw.c-            s390_machine_unprotect(ms);
hw/s390x/s390-virtio-ccw.c-        }
hw/s390x/s390-virtio-ccw.c-
hw/s390x/s390-virtio-ccw.c-        qemu_devices_reset();

Which does a qemu_devices_reset(), we already have a subsystem_reset(),
but for the cases with a PV transition this reset happens before mc->pv
is changed, so I can't react properly in the callback. For my purposes
the qemu_devices_reset() is sufficient, but I'm not sure.

The qemu_devices_reset() seems to come form db3b2566e0 ("s390x: machine
reset function with new ipl cpu handling") authored by David and reviewed by
you.

The subsystem reset from 4e872a3fb0 ("s390: provide I/O subsystem
reset") authored by Christian.

=46rom I quick look, I believe what is done by subsystem_reset() should
be a real subset of what is done by qemu_devices_reset().

Maybe the subsystem_reset() can be just moved and the extra
subsystem_reset() calls added by me can be removed. I didn't look into
that, because it would have been wasted effort if the community rejects this
approach.

I hope this answers your questions!

Thanks for having a look!

Regards,
Halil

