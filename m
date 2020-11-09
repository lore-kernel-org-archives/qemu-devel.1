Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57661C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F04206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 18:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bqDGomep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F04206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcCJB-0002A0-RV
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 13:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kcCIW-0001R3-6t; Mon, 09 Nov 2020 13:53:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1kcCIT-00038f-7P; Mon, 09 Nov 2020 13:53:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A9IX10N024456; Mon, 9 Nov 2020 13:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=8q4ztlAq+7J45tg76YHpckv66q6jW2ALQMtgEHZG9m0=;
 b=bqDGomepVfK3p30H5i7F/sVaDVhpY2Os/zTB3zhsR9Hvj84jGqV3H1UlU5fxoutn2iNA
 4kLhRLuUEIzxIp9Pm1dyW9NCPrStQIcrOS0PDCbTuYDsICtSp2Xd3MFmA3KfdmV2X6IK
 4hN0Urmr074IEA1ZcJAzJNDXM9QD4NmVXtT43HhlQkaONx8mUUdMSo1FN76cFzxOjeiH
 /u2IcUqtJkwE/GKi9V8YuMahG/Yy2lydHkhll//dw46YVk0qlqvDSY22a3rBVnf1KfMg
 Gb8AzqruK95N1O08PYD73PHU4wwfVuk+OUjK3sNN+o1TwNr89WW0pV03AKXSQb68zBwE Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34q71n308d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2020 13:53:42 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A9IYu6i031881;
 Mon, 9 Nov 2020 13:53:41 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34q71n306j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2020 13:53:41 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A9Im86r023143;
 Mon, 9 Nov 2020 18:53:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06ams.nl.ibm.com with ESMTP id 34njuh2b31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2020 18:53:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A9IraMr58917328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2020 18:53:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 184D0A4067;
 Mon,  9 Nov 2020 18:53:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A19ACA405B;
 Mon,  9 Nov 2020 18:53:35 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.80.17])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2020 18:53:35 +0000 (GMT)
Date: Mon, 9 Nov 2020 19:53:03 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] virtio-blk-ccw: tweak the default for num_queues
Message-ID: <20201109195303.459f6fba.pasic@linux.ibm.com>
In-Reply-To: <20201109170616.6875f610.cohuck@redhat.com>
References: <20201109154831.20779-1-pasic@linux.ibm.com>
 <20201109170616.6875f610.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-09_11:2020-11-05,
 2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090127
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 13:53:43
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Michael Mueller <mimu@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Nov 2020 17:06:16 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > @@ -20,6 +21,11 @@ static void virtio_ccw_blk_realize(VirtioCcwDevice *ccw_dev, Error **errp)
> >  {
> >      VirtIOBlkCcw *dev = VIRTIO_BLK_CCW(ccw_dev);
> >      DeviceState *vdev = DEVICE(&dev->vdev);
> > +    VirtIOBlkConf *conf = &dev->vdev.conf;
> > +
> > +    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
> > +        conf->num_queues = MIN(4, current_machine->smp.cpus);
> > +    }  
> 
> I would like to have a comment explaining the numbers here, however.
> 
> virtio-pci has a pretty good explanation (use 1:1 for vqs:vcpus if
> possible, apply some other capping). 4 seems to be a bit arbitrary
> without explanation, although I'm sure you did some measurements :)

Frankly, I don't have any measurements yet. For the secure case,
I think Mimu has assessed the impact of multiqueue, hence adding Mimu to
the cc list. @Mimu can you help us out.

Regarding the normal non-protected VMs I'm in a middle of producing some
measurement data. This was admittedly a bit rushed because of where we
are in the cycle. Sorry to disappoint you.

The number 4 was suggested by Christian, maybe Christian does have some
readily available measurement data for the normal VM case. @Christian:
can you help me out?

Regards,
Halil

