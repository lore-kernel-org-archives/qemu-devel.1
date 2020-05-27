Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99FEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA1720723
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA1720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdrdk-0002RT-S3
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 04:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdrdB-0001zN-69; Wed, 27 May 2020 04:41:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38922
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jdrcf-0006ny-0l; Wed, 27 May 2020 04:41:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04R8d2Ye051122; Wed, 27 May 2020 04:41:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 316yyhm1ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 04:41:11 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04R8fBR0057152;
 Wed, 27 May 2020 04:41:11 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 316yyhm1uf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 04:41:11 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04R8eSaL016692;
 Wed, 27 May 2020 08:41:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03fra.de.ibm.com with ESMTP id 316uf831pe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2020 08:41:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04R8f7bw852368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2020 08:41:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3077A5204F;
 Wed, 27 May 2020 08:41:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.52.97])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C6C6952063;
 Wed, 27 May 2020 08:41:06 +0000 (GMT)
Subject: Re: [PATCH v3 2/9] pc-bios: s390x: Consolidate timing functions into
 time.h
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20200527074920.43669-1-frankja@linux.ibm.com>
 <20200527074920.43669-3-frankja@linux.ibm.com>
 <e9849ad7-c79b-0ace-e9c7-e9818f048397@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cf32a6aa-1c08-194c-cb10-63361d944028@linux.ibm.com>
Date: Wed, 27 May 2020 10:41:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e9849ad7-c79b-0ace-e9c7-e9818f048397@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ATvfKllMZTOh5D4BHCrfEs4FAZeip3Itj"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-27_02:2020-05-26,
 2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 cotscore=-2147483648 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 03:49:35
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ATvfKllMZTOh5D4BHCrfEs4FAZeip3Itj
Content-Type: multipart/mixed; boundary="vAmZSzG6F8USlYihHfgj3Vb7Q403Fphu4"

--vAmZSzG6F8USlYihHfgj3Vb7Q403Fphu4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/27/20 10:36 AM, Christian Borntraeger wrote:
>=20
>=20
> On 27.05.20 09:49, Janosch Frank wrote:
>> Let's consolidate timing related functions into one header.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/menu.c        |  1 +
>>  pc-bios/s390-ccw/netmain.c     | 15 +++------------
>>  pc-bios/s390-ccw/s390-ccw.h    |  2 --
>>  pc-bios/s390-ccw/time.h        | 23 +++++++++++++++++++++++
>=20
> what happened to Thomas comment about a header with the same name from =
SLOF.
> I think it is safer to renamme this one to s390-time.h?

I extensively talked with Thomas about that on IRC and it doesn't seem
to be a problem right now. Since I got no answer to my mail asking if
s390-time.h would be better and he said I don't need to change it when
it works, I just left it like it was and waited for more comments.

>=20
>>  pc-bios/s390-ccw/virtio-net.c  |  1 +
>>  pc-bios/s390-ccw/virtio-scsi.c |  1 +
>>  pc-bios/s390-ccw/virtio.c      | 18 +++---------------
>>  7 files changed, 32 insertions(+), 29 deletions(-)
>>  create mode 100644 pc-bios/s390-ccw/time.h
>>
>> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
>> index ce3815b201..7925c33248 100644
>> --- a/pc-bios/s390-ccw/menu.c
>> +++ b/pc-bios/s390-ccw/menu.c
>> @@ -12,6 +12,7 @@
>>  #include "libc.h"
>>  #include "s390-ccw.h"
>>  #include "sclp.h"
>> +#include "time.h"
>> =20
>>  #define KEYCODE_NO_INP '\0'
>>  #define KEYCODE_ESCAPE '\033'
>> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
>> index 309ffa30d9..73def8de4f 100644
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -35,6 +35,7 @@
>>  #include "s390-ccw.h"
>>  #include "cio.h"
>>  #include "virtio.h"
>> +#include "time.h"
>> =20
>>  #define DEFAULT_BOOT_RETRIES 10
>>  #define DEFAULT_TFTP_RETRIES 20
>> @@ -57,24 +58,14 @@ static SubChannelId net_schid =3D { .one =3D 1 };
>>  static uint8_t mac[6];
>>  static uint64_t dest_timer;
>> =20
>> -static uint64_t get_timer_ms(void)
>> -{
>> -    uint64_t clk;
>> -
>> -    asm volatile(" stck %0 " : : "Q"(clk) : "memory");
>> -
>> -    /* Bit 51 is incremented each microsecond */
>> -    return (clk >> (63 - 51)) / 1000;
>> -}
>> -
>>  void set_timer(int val)
>>  {
>> -    dest_timer =3D get_timer_ms() + val;
>> +    dest_timer =3D get_time_ms() + val;
>>  }
>> =20
>>  int get_timer(void)
>>  {
>> -    return dest_timer - get_timer_ms();
>> +    return dest_timer - get_time_ms();
>>  }
>> =20
>>  int get_sec_ticks(void)
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h=

>> index 21f27e7990..9514b76596 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -74,8 +74,6 @@ unsigned long virtio_load_direct(ulong rec_list1, ul=
ong rec_list2,
>>  bool virtio_is_supported(SubChannelId schid);
>>  void virtio_blk_setup_device(SubChannelId schid);
>>  int virtio_read(ulong sector, void *load_addr);
>> -u64 get_clock(void);
>> -ulong get_second(void);
>> =20
>>  /* bootmap.c */
>>  void zipl_load(void);
>> diff --git a/pc-bios/s390-ccw/time.h b/pc-bios/s390-ccw/time.h
>> new file mode 100644
>> index 0000000000..ed6d982371
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/time.h
>> @@ -0,0 +1,23 @@
>> +#ifndef TIME_H
>> +#define TIME_H
>> +
>> +static inline u64 get_clock(void)
>> +{
>> +    u64 r;
>> +
>> +    asm volatile("stck %0" : "=3DQ" (r) : : "cc");
>> +    return r;
>> +}
>> +
>> +static inline u64 get_time_ms(void)
>> +{
>> +    /* Bit 51 is incremented each microsecond */
>> +    return (get_clock() >> 12) / 1000;
>> +}
>> +
>> +static inline u64 get_time_seconds(void)
>> +{
>> +    return get_time_ms() / 1000;
>> +}
>> +
>> +#endif
>> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-n=
et.c
>> index ff7f4dad25..4de03728bb 100644
>> --- a/pc-bios/s390-ccw/virtio-net.c
>> +++ b/pc-bios/s390-ccw/virtio-net.c
>> @@ -19,6 +19,7 @@
>>  #include <ethernet.h>
>>  #include "s390-ccw.h"
>>  #include "virtio.h"
>> +#include "time.h"
>> =20
>>  #ifndef DEBUG_VIRTIO_NET
>>  #define DEBUG_VIRTIO_NET 0
>> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-=
scsi.c
>> index 4fe4b9d261..0620651da8 100644
>> --- a/pc-bios/s390-ccw/virtio-scsi.c
>> +++ b/pc-bios/s390-ccw/virtio-scsi.c
>> @@ -14,6 +14,7 @@
>>  #include "virtio.h"
>>  #include "scsi.h"
>>  #include "virtio-scsi.h"
>> +#include "time.h"
>> =20
>>  static ScsiDevice default_scsi_device;
>>  static VirtioScsiCmdReq req;
>> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
>> index fb40ca9828..43717b83d7 100644
>> --- a/pc-bios/s390-ccw/virtio.c
>> +++ b/pc-bios/s390-ccw/virtio.c
>> @@ -15,6 +15,7 @@
>>  #include "virtio-scsi.h"
>>  #include "bswap.h"
>>  #include "helper.h"
>> +#include "time.h"
>> =20
>>  #define VRING_WAIT_REPLY_TIMEOUT 30
>> =20
>> @@ -157,19 +158,6 @@ void vring_send_buf(VRing *vr, void *p, int len, =
int flags)
>>      }
>>  }
>> =20
>> -u64 get_clock(void)
>> -{
>> -    u64 r;
>> -
>> -    asm volatile("stck %0" : "=3DQ" (r) : : "cc");
>> -    return r;
>> -}
>> -
>> -ulong get_second(void)
>> -{
>> -    return (get_clock() >> 12) / 1000000;
>> -}
>> -
>>  int vr_poll(VRing *vr)
>>  {
>>      if (vr->used->idx =3D=3D vr->used_idx) {
>> @@ -194,7 +182,7 @@ int vr_poll(VRing *vr)
>>   */
>>  int vring_wait_reply(void)
>>  {
>> -    ulong target_second =3D get_second() + vdev.wait_reply_timeout;
>> +    ulong target_second =3D get_time_seconds() + vdev.wait_reply_time=
out;
>> =20
>>      /* Wait for any queue to be updated by the host */
>>      do {
>> @@ -207,7 +195,7 @@ int vring_wait_reply(void)
>>          if (r) {
>>              return 0;
>>          }
>> -    } while (!vdev.wait_reply_timeout || (get_second() < target_secon=
d));
>> +    } while (!vdev.wait_reply_timeout || (get_time_seconds() < target=
_second));
>> =20
>>      return 1;
>>  }
>>



--vAmZSzG6F8USlYihHfgj3Vb7Q403Fphu4--

--ATvfKllMZTOh5D4BHCrfEs4FAZeip3Itj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7OJ6IACgkQ41TmuOI4
ufjOHA/+KKfzZXYH4j+EG05VaQIM9VCvt2RQDbPPD0l9V/T/Ppf8cHo1kxCqaRdN
rpRfKw195B67Qe4IGM3K7NJUPHLJEcHnYBtEoWzyj8KC5y02oAvd0JQFMQ4obbLP
deTUxztyEs6Wg/EsEUKXOMCgrMiqc2BqcwbPEPy+Am/YyN4BNRN2o7kTgwfwdLgW
/nbKAl0TPHzf7F2o6Jb5sI8A4JwyoSdWkFWhiIU0vTqHHg59+I3F7y+YgqHi9VYc
KAlKrKEWetfgr7URewNLqvJU/DZHeoNHgv/aHttN7GFz8IE38V07Gu3eKkrO3dtz
rkknhr3ouRq8oNoEEosLV82eiCHsgfXFEstqVxnMxsmdWcv22j2ppQGt6Ne+ib/y
c2ao0Z2lgD/Z4kU/flH3z8WqhM+ZiJYLM7v6eKGvNjpgWOKRP9A8i51k/I01OWLQ
1z+0XahWiirEn2MjsDcqJ/GtmZIF7N0uoImR7/rdosESIY7LSThNou85POltP6GK
g9XV9GLfJVwBUerBkFqwl6TwpDS2X06xaBh5wr/4W9p9W1oRAwTUdVixSuMjQjad
6WtdiaG3M3XesI4AIc8D0Eg0pSjRQvHxCxZ7x2eVkdOf+0IgMKDjLQCzQTpEUXKI
MRdBX0pAN17L7gBCB+94d9i9xJ+Kor3xvDqOXiKjja10IrouXcI=
=Qut7
-----END PGP SIGNATURE-----

--ATvfKllMZTOh5D4BHCrfEs4FAZeip3Itj--


