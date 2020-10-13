Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC950C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240F720878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EApgi7WV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240F720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSR36-0004Xl-5L
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kSOEw-0006Kr-4G
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:37:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihai.carabas@oracle.com>)
 id 1kSOEt-00036O-QG
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:37:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DHJmFK102897
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 17:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=A+CdoOtsoE9KWw9WMWmaZJ/Hm5a93Xa3tNLTCep0fhQ=;
 b=EApgi7WVlCAslAzVa81ipLbF6P3vpn46tUALO8H//y7WAg6rovzuvuwxK/vhvhukZxrV
 b23Qsa3cdld5noERYlXWzGGMGycfpLv9deiDs54wv2JfoT9euL/5ag7+e3U+gzOl1uaU
 7el3yhBWbnCfCCDPrbhgH/OXjs2NSogu5SUh/s+dEGmFZmeZljKr3cHKkoMwfxVaFCja
 qV7wgY30VM6td2mdbDk989ijadxGRpsHHj6VQzc31u/138QNgJ4bfRZILwoX4xuranes
 X2YAKHK12jTSX1gAgPjiitd1O2kzESfHHGeKOGxY2teCqF718Itpwg4OhnnycM/VNDJj Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 343vae9tj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 17:37:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DHZexH120489
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 17:37:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 343phngwx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 17:37:26 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09DHbOqH009489
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 17:37:26 GMT
Received: from [10.175.18.76] (/10.175.18.76)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 13 Oct 2020 10:37:24 -0700
To: qemu-devel@nongnu.org
From: Mihai Carabas <mihai.carabas@oracle.com>
Subject: pvpanic mmio support
Message-ID: <a6600c8b-74d9-4c1a-73d9-6302461b7192@oracle.com>
Date: Tue, 13 Oct 2020 20:37:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ro
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773
 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1011
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130127
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=mihai.carabas@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:27:50
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 13 Oct 2020 16:36:02 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Does anyone know if there is any progress with pvpanic patches that 
brings in mmio support [1]? I see no activity since late 2018, but I do 
see support added to the kernel (also asking myself how this was tested):

46f934c misc/pvpanic: add support to get pvpanic device info FDT
b1d9d6c dt-bindings: misc/pvpanic: add document for pvpanic-mmio
725eba2 misc/pvpanic: add MMIO support

Thank you,
Mihai


[1] https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01095.html

