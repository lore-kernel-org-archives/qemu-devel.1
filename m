Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0EAC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618D72078B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FglkhG03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618D72078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOQn-0003Mi-LR
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kDOQ9-0002uQ-QD
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:47:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1kDOQ7-0007Pd-IJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:47:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0828Wqih008464
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2020 04:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=pp1; bh=JSyJMmPAMGPGSY/LLXojigTL+ci4a5beryow/n39wwI=;
 b=FglkhG036KwhJ6bnkDwo5lUvjch0s6fSAt8k7RsopXGu8vg1YM3r6QqSln6l1obQ4oBI
 19FlXOJTlWxY3UK6M1RDQlUxlJrNtwO8UWcasiDv2OWUi28tsom9mpK0cLIfBGLuE4UJ
 dhM1PGb9/taAydLFmLUGQKxHHILjLJdw1znICBW/QynGC3BdDedxXzNHEdmnTK7cbKBs
 7QCoxShRNudkhgY3HrIvytLEUwtLmVacwK5w30td+KuM+F//lc0Ci++9vm6yQppm5Ztw
 Px82LaxkteKvWrmokRha6wMmxGNOivR38zVP/yuk0ZGuRvqqTtc2WDTO1fO0LkhL5m93 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33a6t3tfcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 04:47:01 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0828aFVf019387
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2020 04:47:00 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33a6t3tfcg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2020 04:47:00 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0828hltA028589;
 Wed, 2 Sep 2020 08:46:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03ams.nl.ibm.com with ESMTP id 337en8cfrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2020 08:46:58 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0828kuOK26607910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2020 08:46:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B185042042;
 Wed,  2 Sep 2020 08:46:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 643E242041;
 Wed,  2 Sep 2020 08:46:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.35.147])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2020 08:46:56 +0000 (GMT)
Subject: Re: [PATCH v3 3/5] pc-bios: s390x: Use reset PSW if avaliable
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200831150910.317171-1-frankja@linux.ibm.com>
 <20200831150910.317171-4-frankja@linux.ibm.com>
 <b935f110-d835-e326-d7a9-60d848f970f7@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <93124d79-ded4-52df-3e06-af580fe9f99a@linux.ibm.com>
Date: Wed, 2 Sep 2020 10:46:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b935f110-d835-e326-d7a9-60d848f970f7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7o5CHh9KVjxiqlR6qpDUh2w1YYruD2kuS"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-02_03:2020-09-02,
 2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:27:33
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7o5CHh9KVjxiqlR6qpDUh2w1YYruD2kuS
Content-Type: multipart/mixed; boundary="7GbkoFiBbMYmYoaHiEFZ5d6CztR6iIKOt"

--7GbkoFiBbMYmYoaHiEFZ5d6CztR6iIKOt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/1/20 6:59 PM, Thomas Huth wrote:
> On 31/08/2020 17.09, Janosch Frank wrote:
>> If a blob provides a reset PSW then we should use it instead of
>> branching to the PSW address and using our own mask.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/bootmap.c  |  3 ++-
>>  pc-bios/s390-ccw/jump2ipl.c | 22 +++++++++++++++++-----
>>  pc-bios/s390-ccw/s390-ccw.h |  1 +
>>  3 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index 8747c4ea26..5a03b1eb8b 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -515,7 +515,8 @@ static void zipl_run(ScsiBlockPtr *pte)
>>      IPL_assert(entry->component_type =3D=3D ZIPL_COMP_ENTRY_EXEC, "No=
 EXEC entry");
>> =20
>>      /* should not return */
>> -    jump_to_IPL_code(entry->compdat.load_psw & PSW_MASK_SHORT_ADDR);
>> +    write_reset_psw(entry->compdat.load_psw);
>> +    jump_to_IPL_code(0);
>>  }
>> =20
>>  static void ipl_scsi(void)
>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c=

>> index b6aad32def..5b8352d257 100644
>> --- a/pc-bios/s390-ccw/jump2ipl.c
>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>> @@ -12,15 +12,21 @@
>> =20
>>  #define KERN_IMAGE_START 0x010000UL
>>  #define RESET_PSW_MASK (PSW_MASK_SHORTPSW | PSW_MASK_64)
>> +#define RESET_PSW ((uint64_t)&jump_to_IPL_addr | RESET_PSW_MASK)
>> =20
>>  static uint64_t *reset_psw =3D 0, save_psw, ipl_continue;
>> =20
>> +void write_reset_psw(uint64_t psw)
>> +{
>> +    *reset_psw =3D psw;
>> +}
>> +
>>  static void jump_to_IPL_addr(void)
>>  {
>>      __attribute__((noreturn)) void (*ipl)(void) =3D (void *)ipl_conti=
nue;
>> =20
>>      /* Restore reset PSW */
>> -    *reset_psw =3D save_psw;
>> +    write_reset_psw(save_psw);
>> =20
>>      ipl();
>>      /* should not return */
>> @@ -43,9 +49,10 @@ void jump_to_IPL_code(uint64_t address)
>>       * content of non-BIOS memory after we loaded the guest, so we
>>       * save the original content and restore it in jump_to_IPL_2.
>>       */
>> -    save_psw =3D *reset_psw;
>> -    *reset_psw =3D (uint64_t) &jump_to_IPL_addr;
>> -    *reset_psw |=3D RESET_PSW_MASK;
>> +    if (address) {
>> +        save_psw =3D *reset_psw;
>> +        write_reset_psw(RESET_PSW);
>> +    }
>>      ipl_continue =3D address;
>>      debug_print_int("set IPL addr to", ipl_continue);
>=20
> In case you respin this series, I think I'd move the "ipl_continue =3D
> address" into the if-statement, too, and change the debug_print_int lin=
e
> to use address instead of ipl_continue.

Hmm, my intention was to always have something printed.
But I guess it would make more sense to print the reset psw addr in the
~address case.


>=20
>> @@ -77,7 +84,12 @@ void jump_to_low_kernel(void)
>> =20
>>      /* Trying to get PSW at zero address */
>>      if (*((uint64_t *)0) & RESET_PSW_MASK) {
>> -        jump_to_IPL_code((*((uint64_t *)0)) & PSW_MASK_SHORT_ADDR);
>> +        /*
>> +         * Surely nobody will try running directly from lowcore, so
>> +         * let's use 0 as an indication that we want to load the rese=
t
>> +         * psw at 0x0 and not jump to the entry.
>> +         */
>> +        jump_to_IPL_code(0);
>>      }
>> =20
>>      /* No other option left, so use the Linux kernel start address */=

>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h=

>> index 36b884cced..7090720422 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -78,6 +78,7 @@ int virtio_read(ulong sector, void *load_addr);
>>  void zipl_load(void);
>> =20
>>  /* jump2ipl.c */
>> +void write_reset_psw(uint64_t psw);
>>  void jump_to_IPL_code(uint64_t address);
>>  void jump_to_low_kernel(void);
>=20
> Looks sane to me:
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20
>=20



--7GbkoFiBbMYmYoaHiEFZ5d6CztR6iIKOt--

--7o5CHh9KVjxiqlR6qpDUh2w1YYruD2kuS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl9PXAAACgkQ41TmuOI4
ufiTSg/9F3KlR6c7Ed8dqI44iPSGFdBOp5tVxjcv2l+Cqeowo2Wg6ckjFi2wMee4
M8UezThM6r0vRQQ9arXxVCdV2Zf0r/ZUpCjpQYihZXpV3zo3qZENVAc3+OI72Ngk
iXGQ7kz8OwbuMR7zT4aZRYn3VfMt6/k4bvnCRK0CQLGP/ITcIjeKNg8P/bXEKkjq
ENWw03knsGZsEkVe1D1txbzYSFR6wbzZHvKXWapfm0IAcu6f2XTUhjL2PbIAdcdG
EG72DQWHy1nlFjOOM+auGRa1Q/W/M2zeIqzBpJf7tkf7fTBHm2oj/8P2jJF/Q9DQ
3I4giMe13uznK0KyhzewpgRsBoetFA0Y3mf0x0Sr3RXckxvyjvqxCZvbPLMuvekZ
3T4wDNJPvLxcKum1c+IkMZ0xpBGcHAa+3GZx5xUGiOxmbWaT+iow/4QL30KSGYXV
3wmkg1Kb/UH5Is7vU1BRO8B/5nMYeWxxPRbGCnbFm3oLx/lzJMse0y+PsB98pKVQ
ISeCsxggX2uITr0h1Bh3sOkR2mxy63lK23agqe0ISfoB81QKx8eTkkG0tH5aw4V4
LbxYcSFlGcXs4Y9hTNRaeJ99pAlxHkOrjMb+aK3Aj2uSx0lIFfXfPMDBx0wFawjT
+iBskHyT5360N5MQRmIbp13xkcaPohmEJ5cxV8G/v/OQmkk+xLo=
=9+vG
-----END PGP SIGNATURE-----

--7o5CHh9KVjxiqlR6qpDUh2w1YYruD2kuS--


