Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F886C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D13F23741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XsiQfK4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D13F23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSLw-0003mU-9n
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kLSKD-0002Ne-Kq
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:34:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kLSKB-0004t7-LG
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:34:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OETGoD190354;
 Thu, 24 Sep 2020 14:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=wicPfWWs0gZXyOPqSrsYHkt4eQjQWW11YGZuewuxWcE=;
 b=XsiQfK4PHrUXVQ5k1qfi9p95R3FOjCy4f7vNaQfRyP86K3adOCBxaFiy5gXnVbQh1mMt
 +Ld9zeXs4559byGV3I3O6VvM5IXE5s3WhcIoGqxgS0u5DNCgVwL872cT5vVn2Mh7Mjzo
 7SmPEelItE0D2ciUFDZ1aYTArIwJFVN1oHP0w9Qx487QSrCOPGZzqvajUgBt2rPh5Gmo
 8wn197W+41gQXsIa1oDqBdg3z0i0EsX92IPlZ0A7c1Iwhm089wmsmma3xRp/bp2VRrKP
 cKsFOusZ74JdiJzaLsaM1W3bX4By92pgxifuS1v92Q2JlGHXUTGav73NsRXK3InOPhoj mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 33q5rgq0nr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 14:33:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OEVTA4041991;
 Thu, 24 Sep 2020 14:33:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 33nux2v47q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 14:33:56 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OEXtB6008432;
 Thu, 24 Sep 2020 14:33:55 GMT
Received: from dhcp-10-39-218-110.vpn.oracle.com (/10.39.218.110)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 07:33:54 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v9 00/20] Initial support for multi-process Qemu
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200924083841.GQ62770@stefanha-x1.localdomain>
Date: Thu, 24 Sep 2020 10:33:51 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE596DB1-5104-48E3-B63D-83534DADDAE0@oracle.com>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200924083841.GQ62770@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=3 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0
 clxscore=1011 suspectscore=3 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240110
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 10:34:11
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Sep 24, 2020, at 4:38 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Thu, Aug 27, 2020 at 11:12:11AM -0700, elena.ufimtseva@oracle.com =
wrote:
>> The v9 has the following changes:
>> - Communication channel. Qemu side uses blocking call to send
>>  and receive the message from the remote and cannot progress
>>  further until the remote side replies. Enhanced the
>>  communication channel by dropping iothread lock before blocking
>>  on Qemu end. Use the co-routines on the remote end to avoid
>>  blocking QMP monitor;
>> - removed the heartbeat functionality, it will be added later
>>  in a full extent;
>> - fixed leaked errors and similar fixes;
>> - eliminated bytestream passing over the channel;
>> - The build system had to be changed in order to accomodate the
>>  latest changes in Qemu to use Kconfig/mason.
>=20
> Thanks, I left comments but I'm happy with most patches now.

Thank you for the comments, Stefan. We will address them in the next =
series.

=E2=80=94
Jag

>=20
> Stefan


