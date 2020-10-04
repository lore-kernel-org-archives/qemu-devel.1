Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024E9C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CF92068D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KQiTqQsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CF92068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8th-0001R1-9t
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kP8sS-0000Yg-4h
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:36:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1kP8sP-0003P8-M0
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:36:55 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 094IXNYT067629; Sun, 4 Oct 2020 14:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MDlFg0KyL/nxfGd9lXgo4Or5oCuCob+tcAhfwW0ecgQ=;
 b=KQiTqQswvKdcVMxgKSZF6DFMVrEMhltEVZstoX37RGIbWgwV2zMPqEq6cthJxeZecDOk
 B3L5+tSZWQ6wEaukUM2mO4RUhc98B5XzJupTHMIj0qt5L7EPR9+jcseMFJNWGANTLBHd
 sV5kmzhQg1o/71gkYOiZZTe/BwIZz9vAUg3B/RDJIsF0C1VzsRRIpl5aprkiyWN9i8Jz
 XRAchr0cbEkvh8Ef3mBzl5ruEcls0LLEFki5AYqgoAG1iB1UpaG8Oq7wfjEe5I7/TmmW
 8d+lT89hmEB5lbjgr+YpQ+Xv9FHETL176D/u1LUZ7JoRRuvKnf1awycSzg4d9bKUFlu0 CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33yk7prmhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 Oct 2020 14:36:45 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 094IYZqN069297;
 Sun, 4 Oct 2020 14:36:45 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33yk7prmhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 Oct 2020 14:36:45 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 094ISKvA030193;
 Sun, 4 Oct 2020 18:36:44 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma04dal.us.ibm.com with ESMTP id 33xgx8vqaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 Oct 2020 18:36:44 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 094IahM723003582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 4 Oct 2020 18:36:43 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76F27AC059;
 Sun,  4 Oct 2020 18:36:43 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5443FAC05B;
 Sun,  4 Oct 2020 18:36:43 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Sun,  4 Oct 2020 18:36:43 +0000 (GMT)
Subject: Re: [RFC PATCH 2/2] .mailmap: Fix more contributor entries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201004172644.2027440-1-f4bug@amsat.org>
 <20201004172644.2027440-3-f4bug@amsat.org>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <6271086e-b8e7-c7c9-a00e-8f4e25935ecc@linux.ibm.com>
Date: Sun, 4 Oct 2020 14:36:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201004172644.2027440-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-04_17:2020-10-02,
 2020-10-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxlogscore=961 mlxscore=0 clxscore=1011
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010040142
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 14:36:50
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Andrew Melnychenko <andrew@daynix.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Anup Patel <anup.patel@wdc.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, David Carlier <devnexen@gmail.com>,
 Erik Smit <erik.lucas.smit@gmail.com>, Marek Dolata <mkdolata@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/20 1:26 PM, Philippe Mathieu-Daudé wrote:
> These authors have some incorrect author email field.
> For each of them, there is one commit with the replaced
> entry.
>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Andrew Melnychenko <andrew@daynix.com>
> Cc: David Carlier <devnexen@gmail.com>
> Cc: Erik Smit <erik.lucas.smit@gmail.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Pan Nengyuan <pannengyuan@huawei.com>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Acked-by: Stefan Berger <stefanb@linux.ibm.com>



