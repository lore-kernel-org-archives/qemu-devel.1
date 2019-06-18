Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDF2C31E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2161420673
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JmmaQtHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2161420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59608 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdH2U-0002NI-6U
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60621)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hdGAc-0003Pv-Fx
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hdGAW-0004N7-NW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:37:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hdGAU-00047e-O3
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:37:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IFOVY1151641;
 Tue, 18 Jun 2019 15:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=AApMw5TsMqN6YhoPm41GCwqHYefC7ikF/FburAdTeBc=;
 b=JmmaQtHHEeTv8Q0MOzglhPEAuCKzTdKcD9OEfqLch2TLS0edOmkak2q3QEKb/gThXqbz
 7t10mOg1GlkPj2AosylouLRTA9qlwwPep/ubMKlqAs8mZiSTXXy1h9uvlLhujVt569mU
 eqkuFbxhWZvg92iJnFFEgxqIFQ93EsahbDdRWD0gsfjsWssCOKQzQc7Ti4sPhygj9Arg
 1PBy9+ma15TZTU0mxQimAlXvaXubWWNZ9KUH/+X3OTOnY7K5p7BVBbgWbmWL/BP79gh9
 D0a9nZI8wNrBTHNin0t+gxsNHCTwsHFHORKqKZXdQeRm+WS0tp4a5qaO14PcwTKqT1Gg kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2t4r3tnbs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 15:36:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5IFZ7bu030672;
 Tue, 18 Jun 2019 15:36:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2t5h5ttcxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 15:36:57 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5IFauo6013961;
 Tue, 18 Jun 2019 15:36:56 GMT
Received: from [192.168.14.112] (/109.67.217.108)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 18 Jun 2019 08:36:56 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190618085539.GB2850@work-vm>
Date: Tue, 18 Jun 2019 18:36:51 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB34E76F-231C-4E66-B5CB-113AFCE7A20F@oracle.com>
References: <20190617175658.135869-1-liran.alon@oracle.com>
 <20190617175658.135869-7-liran.alon@oracle.com>
 <20190618085539.GB2850@work-vm>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906180123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906180123
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [QEMU PATCH v3 6/9] vmstate: Add support for
 kernel integer types
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 jmattson@google.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 18 Jun 2019, at 11:55, Dr. David Alan Gilbert <dgilbert@redhat.com> =
wrote:
>=20
> * Liran Alon (liran.alon@oracle.com) wrote:
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>> include/migration/vmstate.h | 18 ++++++++++++++++++
>> 1 file changed, 18 insertions(+)
>>=20
>> diff --git a/include/migration/vmstate.h =
b/include/migration/vmstate.h
>> index 9224370ed59a..a85424fb0483 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -797,6 +797,15 @@ extern const VMStateInfo vmstate_info_qtailq;
>> #define VMSTATE_UINT64_V(_f, _s, _v)                                  =
\
>>     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, uint64_t)
>=20
> A comment here stating they're for Linux kernel types would be nice.

I didn=E2=80=99t want to state this because in theory these types can be =
used not in kernel context=E2=80=A6
I thought commit message is sufficient. I think comments in code should =
be made to clarify
things. But to justify existence I think commit message should be used.
But if you insist, I have no strong objection of adding such comment.

>=20
>> +#define VMSTATE_U8_V(_f, _s, _v)                                   \
>> +    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint8, __u8)
>> +#define VMSTATE_U16_V(_f, _s, _v)                                  \
>> +    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint16, __u16)
>> +#define VMSTATE_U32_V(_f, _s, _v)                                  \
>> +    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint32, __u32)
>> +#define VMSTATE_U64_V(_f, _s, _v)                                  \
>> +    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, __u64)
>> +
>=20
> Have you checked that builds OK on a non-Linux system?

Hmm that=E2=80=99s a good point. No. :P

-Liran

>=20
> Dave
>=20
>> #define VMSTATE_BOOL(_f, _s)                                          =
\
>>     VMSTATE_BOOL_V(_f, _s, 0)
>>=20
>> @@ -818,6 +827,15 @@ extern const VMStateInfo vmstate_info_qtailq;
>> #define VMSTATE_UINT64(_f, _s)                                        =
\
>>     VMSTATE_UINT64_V(_f, _s, 0)
>>=20
>> +#define VMSTATE_U8(_f, _s)                                         \
>> +    VMSTATE_U8_V(_f, _s, 0)
>> +#define VMSTATE_U16(_f, _s)                                        \
>> +    VMSTATE_U16_V(_f, _s, 0)
>> +#define VMSTATE_U32(_f, _s)                                        \
>> +    VMSTATE_U32_V(_f, _s, 0)
>> +#define VMSTATE_U64(_f, _s)                                        \
>> +    VMSTATE_U64_V(_f, _s, 0)
>> +
>> #define VMSTATE_UINT8_EQUAL(_f, _s, _err_hint)                        =
\
>>     VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 =
\
>>                         vmstate_info_uint8_equal, uint8_t, _err_hint)
>> --=20
>> 2.20.1
>>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


