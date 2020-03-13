Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED47C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA9220749
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TgsE3sO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA9220749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCn6I-0001hS-0r
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCn5T-0000pg-66
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCn5R-0003A2-6G
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:23:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCn5Q-0002yN-TC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:23:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DGMd06010827;
 Fri, 13 Mar 2020 16:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0EdFkrhfd/gMBDY+TmHnVT+G4xDEhbERA5+HBj4oVMQ=;
 b=TgsE3sO2ahManhj4hovnRmFPui8E3mD5QSaOpt+Ga1gj12gO/M/5RjXoW5rkIbm4ghbU
 wEWQxRdlNBqlLQQo8dDVcyb9guQ7cia/ORbaPy6MPns8wFTHugqh5Ftz77MleYr7BtQc
 +SVDlGgQ78ThV68DCqDdvaNdAZEnU30kFroepK60Bg2X9szthRUtarz3h5qsrSog2H+9
 +PhdI9Txyghn3/ayff+VqfyXkbdYbmMHk1oIXgwz8h7CoLuE/+38Y+aLCqZIPlX2swl7
 dpX6HkBW+duNUHFWnmgPQOOM3k/Z1F6rxSDFnEXh6oT/MqjiycXDlfj9eW0hRskprgx+ MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2yqtaevp5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 16:22:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DGJQKg025673;
 Fri, 13 Mar 2020 16:22:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2yqtawa3cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 16:22:58 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02DGMvvU018592;
 Fri, 13 Mar 2020 16:22:57 GMT
Received: from [192.168.14.112] (/109.67.207.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 09:22:57 -0700
Subject: Re: [PATCH v2 0/3]: acpi: Add Windows ACPI Emulated Device Table
 (WAET)
To: qemu-devel@nongnu.org
References: <158411510863.16773.11681485784155170393@39012742ff91>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <f96bcd5d-4e33-33d0-109e-00bf71aca000@oracle.com>
Date: Fri, 13 Mar 2020 18:22:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158411510863.16773.11681485784155170393@39012742ff91>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130083
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
Cc: pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 13/03/2020 17:58, no-reply@patchew.org wrote:
> Patchew URL: https://urldefense.com/v3/__https://patchew.org/QEMU/20200313145009.144820-1-liran.alon@oracle.com/__;!!GqivPVa7Brio!MCIj6t775fgVLQyuc_7yakcjRzbRpb0QfWeBkZaMwb72--7RvXHTCgm_18diSyk$
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Subject: [PATCH v2 0/3]: acpi: Add Windows ACPI Emulated Device Table (WAET)
> Message-id: 20200313145009.144820-1-liran.alon@oracle.com
> Type: series
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> e9129fb acpi: unit-test: Update WAET ACPI Table expected binaries
> 76eaa7a acpi: Add Windows ACPI Emulated Device Table (WAET)
> 041dfae acpi: unit-test: Ignore diff in WAET ACPI table
>
> === OUTPUT BEGIN ===
> 1/3 Checking commit 041dfaefd37e (acpi: unit-test: Ignore diff in WAET ACPI table)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #17:
> new file mode 100644
>
> total: 0 errors, 1 warnings, 3 lines checked
>
> Patch 1/3 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 2/3 Checking commit 76eaa7ac6ef4 (acpi: Add Windows ACPI Emulated Device Table (WAET))
> ERROR: line over 90 characters
> #43: FILE: hw/i386/acpi-build.c:2520:
> + * Spec: https://urldefense.com/v3/__http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97E-CE7CE0D98DC2/WAET.docx__;!!GqivPVa7Brio!MCIj6t775fgVLQyuc_7yakcjRzbRpb0QfWeBkZaMwb72--7RvXHTCgm_RmMn38k$
Just wanted to note that this is intentional. I didn't want to break the 
URL to multiple lines.
>
> WARNING: Block comments use a leading /* on a separate line
> #61: FILE: hw/i386/acpi-build.c:2538:
> +    build_append_int_noprefix(table_data, 1 << 1 /* ACPI PM timer good */, 4);
Same here. Intentional. Seems to match the coding convention of other 
places in acpi-build.c.
>
> total: 1 errors, 1 warnings, 43 lines checked
>
> Patch 2/3 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> 3/3 Checking commit e9129fbd5cf2 (acpi: unit-test: Update WAET ACPI Table expected binaries)
> === OUTPUT END ===
>
> Test command exited with code: 1
>
>
> The full log is available at
> https://urldefense.com/v3/__http://patchew.org/logs/20200313145009.144820-1-liran.alon@oracle.com/testing.checkpatch/?type=message__;!!GqivPVa7Brio!MCIj6t775fgVLQyuc_7yakcjRzbRpb0QfWeBkZaMwb72--7RvXHTCgm_VGFnBLg$ .
> ---
> Email generated automatically by Patchew [https://urldefense.com/v3/__https://patchew.org/__;!!GqivPVa7Brio!MCIj6t775fgVLQyuc_7yakcjRzbRpb0QfWeBkZaMwb72--7RvXHTCgm_RlK35c8$ ].
> Please send your feedback to patchew-devel@redhat.com

