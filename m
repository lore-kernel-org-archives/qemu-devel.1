Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC60C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40F82067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XWIUyM7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40F82067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRiq-0005WK-UZ
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCRiC-00056t-2J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCRi9-00055h-7I
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:33:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCRi8-00054X-U4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:33:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CHU5MH184621;
 Thu, 12 Mar 2020 17:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1k5neVzAI2t8O/+MOXu8yGGxm13ucX5gYysItt7VSOE=;
 b=XWIUyM7OGV5VFe1dTKx65KHGFNXmDos/Xkw9LN/SOFLbzpy3njjCeJLXGlbIkCZonb+c
 jE7W5EzoLZ2Jp4C2BjQElF9Ri32wX6lVx0sX5tcXbYtf9rMBJfmCmjXXdGEHoUp0rN09
 oi7lQMTVXzxIIp4fH3jEKk+Izw5dqPnspdGE/BsGMDDJn8Xyxbn5On6jd7ZOUPhGy7xu
 UXaV1UYjG3NDUQZmpnLtFcqQi/QVpOpy89tNEIugPNKlwFjWLLQUDHDjSIaz7WTm++bo
 Im9jB95MZ88riLuM8SbjYtzWmWD+nX+zG1KGjPHLMLBW7Hu4NY+dM//r//KK0Hil5ITM WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2yp9v6e3qt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 17:33:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CHX5YI157645;
 Thu, 12 Mar 2020 17:33:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2yp8r0vdp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 17:33:10 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CHSa2v021888;
 Thu, 12 Mar 2020 17:28:36 GMT
Received: from Lirans-MacBook-Pro.local (/10.74.126.134)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 10:28:35 -0700
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
To: Igor Mammedov <imammedo@redhat.com>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200312172745.1b7b2222@redhat.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <8b3f3166-cc60-eae2-c20d-ad4a593c3e30@oracle.com>
Date: Thu, 12 Mar 2020 19:28:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312172745.1b7b2222@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120089
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 02CHU5MH184621
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/03/2020 18:27, Igor Mammedov wrote:
> On Wed, 11 Mar 2020 19:08:26 +0200
> Liran Alon <liran.alon@oracle.com> wrote:
>> +
>> +static void
>> +build_waet(GArray *table_data, BIOSLinker *linker)
> see build_hmat_lb() for example how to doc comment for such function
> should look like. Use earliest spec version where table was introduced.

Note that WAET is a table that is not part of ACPI spec officially.
It's specified on it's own document, there is only a single version, and=20
there is only a single table in that document describing that table=20
structure.

Therefore, I cannot write a comment such as build_hmat_lb() have:
/*
 =C2=A0* ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Informa=
tion
 =C2=A0* Structure: Table 5-146
*/

My best attempt to do something similar in v2 is:
/*
 =C2=A0* Windows ACPI Emulated Devices Table
 =C2=A0* (Version 1.0 - April 6, 2009)
 =C2=A0* Spec:=20
http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97E-CE7C=
E0D98DC2/WAET.docx
 =C2=A0*
 =C2=A0* Helpful to speedup Windows guests and ignored by others.
 =C2=A0*/

If it's not sufficient. Please suggest alternative phrasing which I=20
would use in v2.

>
>> +{
>> +    AcpiTableWaet *waet;
>> +
>> +    waet =3D acpi_data_push(table_data, sizeof(*waet));
>> +    waet->emulated_device_flags =3D cpu_to_le32(ACPI_WAET_PM_TIMER_GO=
OD);
> we don't use packed structures for building ACPI tables anymore (there =
is
> old code that still does but that's being converted when we touch it)
>
> pls use build_append_int_noprefix() api instead, see build_amd_iommu() =
as
> an example how to build binary tables using it and how to use comments
> to document fields.
> Basic idea is that api makes function building a table match table's
> description in spec (each call represents a row in spec) and comment
> belonging to a row should contain verbatim field name as used by spec
> so reader could copy/past and grep it easily.
Thanks for pointing this out.
I will make sure to update my code accordingly in v2.
>
>
>
>
>> +
>> +    build_header(linker, table_data,
>> +                 (void *)waet, "WAET", sizeof(*waet), 1, NULL, NULL);
>> +}
>> +
>>   /*
>>    *   IVRS table as specified in AMD IOMMU Specification v2.62, Secti=
on 5.2
>>    *   accessible here https://urldefense.com/v3/__http://support.amd.=
com/TechDocs/48882_IOMMU.pdf__;!!GqivPVa7Brio!On_WsDCS8ysOeUG17h1l3dTpWEm=
79AHwMHLbbUgsvagBSpgZAk5U1cXddn6ZNOU$
>> @@ -2859,6 +2872,11 @@ void acpi_build(AcpiBuildTables *tables, Machin=
eState *machine)
>>                             machine->nvdimms_state, machine->ram_slots=
);
>>       }
>>  =20
>> +    if (!pcmc->do_not_add_waet_acpi) {
>> +        acpi_add_table(table_offsets, tables_blob);
>> +        build_waet(tables_blob, tables->linker);
>> +    }
> we typically do not version ACPI table changes (there might be exceptio=
ns
> but it should be a justified one).
> ACPI tables are considered to be a part of firmware (even though they a=
re
> generated by QEMU) so on QEMU upgrade user gets a new firmware along wi=
th
> new ACPI tables.

Hmm... I would have expected as a QEMU user that upgrading QEMU may=20
update my firmware exposed table (Such as ACPI),
but only if I don't specify I wish to run on a specific machine-type. In=20
that case, I would've expect to be exposed with exact same firmware=20
information.
I understood that this was one of the main reasons why ACPI/SMBIOS=20
generation was moved from SeaBIOS to QEMU.

If you think this isn't the case, I can just remove this flag (Makes=20
code simpler). What do you prefer?

Thanks for the review,
-Liran



