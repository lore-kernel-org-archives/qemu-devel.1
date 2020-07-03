Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D484FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43B3206E2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jHIaD4nz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43B3206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrMTa-0001J9-LH
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 10:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shen.mengjiao3@icloud.com>)
 id 1jrLwE-0003hy-Ra
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:41:10 -0400
Received: from pv50p00im-ztdg10021901.me.com ([17.58.6.55]:39313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shen.mengjiao3@icloud.com>)
 id 1jrLwD-0005Fz-Cz
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; t=1593783654;
 bh=yfCrf8VQzypzRzrFLJxbK/OYwvm8fNHCQgeqTMOKTUQ=;
 h=Content-Type:From:Date:Subject:Message-Id:To;
 b=jHIaD4nz223Rf3LA1Wqt/h5XS+TfW1y60ORN435O6QmXC7NBsL+HmY3tu5WAzZIQi
 /vQyp0SIcxRalTyyIUTUVGH9IQ7n/Igz51TZvngWmNRcZtX3X3mEQJhK4uCqZrotuM
 FFlckzs3UnQ3HN/IRTMzVVUrP5X1odflbmXJ71GcvjuUnyfHfsFgfTZveWhefsdFY6
 ALqkVri+PhQrnTF/P41Z2mjaF9e/lTKayI/yyYhO1QBYQOsvc2p3p9MunUl30whXAK
 5QAZWpEj+T1XhN1JJzX0HxlIOWJT3wT8+1sb4cZ9v9BqgxWazXiJA6o8HxHoLC3bXe
 rAIUJJqbudBSQ==
Received: from [192.168.50.83] (unknown [223.166.236.161])
 by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id D018788064E
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2020 13:40:51 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?B?5rKI5qKm5aej?= <shen.mengjiao3@icloud.com>
Mime-Version: 1.0 (1.0)
Date: Fri, 3 Jul 2020 21:40:40 +0800
Subject: How the cpu_R in DisasContext is associated with register of
 CPUArchState
Message-Id: <6AE6C8C0-3EDF-4501-AF11-0ECFBCBBB5FB@icloud.com>
To: qemu-devel@nongnu.org
X-Mailer: iPhone Mail (17E262)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-03_09:2020-07-02,
 2020-07-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=432 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2004280000 definitions=main-2007030096
Received-SPF: pass client-ip=17.58.6.55;
 envelope-from=shen.mengjiao3@icloud.com; helo=pv50p00im-ztdg10021901.me.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 09:40:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 03 Jul 2020 10:15:01 -0400
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

Because in translate stage when write cpu register by guest code, it operate=
s totally on cpu_R of DisasContext, how to reflect it to register of CPUArch=
State?

thanks a lot!=

