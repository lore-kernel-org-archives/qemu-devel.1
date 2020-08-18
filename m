Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 01:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861562075E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 01:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dkFrgpa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861562075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7qhC-000280-OU
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 21:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k7qgE-0001K3-K8; Mon, 17 Aug 2020 21:44:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9170)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k7qgC-00023D-HI; Mon, 17 Aug 2020 21:44:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07I1VkSe042861; Mon, 17 Aug 2020 21:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=vWgNd0droBgNxocrSnsVRySZHFefJUGvUyzFU0tOJsY=;
 b=dkFrgpa1+1IuTd+v8sMxc208qemUMQUa+YDWIOTv2hBiFFD133V2qUmCvpUUVvb2ern6
 By7gdUkkE3mnigA9g7Tw5KeV+PuQYjCiCAulXJHseagTAfB5BFkvEQph7prGPVRRFEkX
 TMJfdtvZfIy41eqB0dzNO+vseVDZnCiuEmuROITLzQkCzrehaD7cDhB4BkTPq3Iw7Pkz
 RGynwmjIFuxDKbUdPU8WkfiL9rYP3jnvv9AHb4Qk/a159ZSxOWjfAi4xtmnHfwABMhcB
 L64HLHjIInluHda1r0mJ1CBVGkgPhnKVA75XoaIz28R+t4I83Ih+QqOu9r3EurOdQZSs Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304tdh0vf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2020 21:44:06 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07I1W4uS043396;
 Mon, 17 Aug 2020 21:44:05 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3304tdh0uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2020 21:44:05 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07I1dQ6E013898;
 Tue, 18 Aug 2020 01:44:04 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03dal.us.ibm.com with ESMTP id 3304cc8fxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2020 01:44:04 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07I1i4pJ37224820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2020 01:44:04 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C8E3112062;
 Tue, 18 Aug 2020 01:44:04 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4452112061;
 Tue, 18 Aug 2020 01:43:57 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.138.167])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
 Tue, 18 Aug 2020 01:43:57 +0000 (GMT)
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200817044730.GK12805@yekko.fritz.box>
 <83ebefab-8bdf-2584-53e6-e4fa0f540109@redhat.com>
 <20200817054306.GL12805@yekko.fritz.box>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 0/8] Generalize start-powered-off property from ARM
In-reply-to: <20200817054306.GL12805@yekko.fritz.box>
Date: Mon, 17 Aug 2020 22:43:52 -0300
Message-ID: <87mu2s7mp3.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-17_15:2020-08-17,
 2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180006
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 21:44:44
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Gibson <david@gibson.dropbear.id.au> writes:

> On Mon, Aug 17, 2020 at 07:24:43AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 8/17/20 6:47 AM, David Gibson wrote:
>> > On Wed, Jul 22, 2020 at 11:56:49PM -0300, Thiago Jung Bauermann wrote:
>> >> The ARM code has a start-powered-off property in ARMCPU, which is a
>> >> subclass of CPUState. This property causes arm_cpu_reset() to set
>> >> CPUState::halted to 1, signalling that the CPU should start in a halt=
ed
>> >> state. Other architectures also have code which aim to achieve the sa=
me
>> >> effect, but without using a property.
>> >>
>> >> The ppc/spapr version has a bug where QEMU does a KVM_RUN on the vcpu
>> >> before cs->halted is set to 1, causing the vcpu to run while it's sti=
ll in
>> >> an unitialized state (more details in patch 3).
>> >>
>> >> Peter Maydell mentioned the ARM start-powered-off property and
>> >> Eduardo=C3=82 Habkost suggested making it generic, so this patch seri=
es does
>> >> that, for all cases which I was able to find via grep in the code.
>> >>
>> >> The only problem is that I was only able to test these changes on a p=
pc64le
>> >> pseries KVM guest, so except for patches 2 and 3, all others are only
>> >> build-tested. Also, my grasp of QOM lifecycle is basically non-exista=
nt so
>> >> please be aware of that when reviewing this series.
>> >>
>> >> The last patch may be wrong, as pointed out by Eduardo, so I marked i=
t as
>> >> RFC. It may make sense to drop it.
>> >>
>> >> Applies cleanly on yesterday's master.
>> >
>> > This series appears to break the Travis build for a MIPS target:
>> >
>> > Unexpected error in qdev_prop_set_after_realize() at /home/travis/buil=
d/dgibson/qemu/hw/core/qdev-properties.c:30:
>> > qemu-system-mips64el: Attempt to set property 'start-powered-off' on a=
nonymous device (type 'I6400-mips64-cpu') after it was realized
>> > Broken pipe
>> > /home/travis/build/dgibson/qemu/tests/qtest/libqtest.c:175: kill_qemu(=
) detected QEMU death from signal 6 (Aborted) (core dumped)
>> > Aborted (core dumped)
>> > ERROR qom-test - too few tests run (expected 8, got 0)
>> > /home/travis/build/dgibson/qemu/tests/Makefile.include:650: recipe for=
 target 'check-qtest-mips64el' failed
>>
>> Good catch. hw/mips/cps.c, hw/ppc/e500.c and hw/sparc/sun4m.c are
>> incorrectly setting the property after the cpu is realized because
>> the cpu is created with cpu_create(). We need to create them with
>> object_initialize_child() and realize them manually with qdev_realize().

Does it have to be with object_initialize_child()? I found very few
examples of CPUs initialized with that function (e.g., atmega.c,
rx62n.c, nrf51_soc.c).

A more direct substitute for cpu_create() would be object_new(). I
provide an example at the end of this email. What do you think?

I'm trying to test it with `make=C2=A0docker-test-misc@debian-mips64el-cros=
s`,
but still having some trouble with that. Is there another way to
reproduce this issue?

> Thiago, can you fix that up and repost please.

Ok, I'm working on it.

--
Thiago Jung Bauermann
IBM Linux Technology Center


diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index d5b6c78019..be85357dc0 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -73,7 +73,9 @@ static void mips_cps_realize(DeviceState *dev, Error **er=
rp)
     bool saar_present =3D false;
=20
     for (i =3D 0; i < s->num_vp; i++) {
-        cpu =3D MIPS_CPU(cpu_create(s->cpu_type));
+        Error *err =3D NULL;
+
+        cpu =3D MIPS_CPU(object_new(s->cpu_type));
=20
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -90,6 +92,12 @@ static void mips_cps_realize(DeviceState *dev, Error **e=
rrp)
         object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
                                  &error_abort);
         qemu_register_reset(main_cpu_reset, cpu);
+
+        if (!qdev_realize(DEVICE(cpu), NULL, &err)) {
+            error_report_err(err);
+            object_unref(OBJECT(cpu));
+            exit(EXIT_FAILURE);
+        }
     }
=20
     cpu =3D MIPS_CPU(first_cpu);

