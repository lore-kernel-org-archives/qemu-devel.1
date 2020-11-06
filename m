Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30141C388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 01:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C827206FB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 01:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uIBa296Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C827206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaqus-0007ii-6U
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 20:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1kaqtw-0007E7-Bu
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 20:50:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1kaqtq-0003Xc-43
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 20:50:50 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A61oXVa171573;
 Fri, 6 Nov 2020 01:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=r1Fyw+C/L+6blVywgAEXkJVwFWNiGZtC/9UZeOSqhUk=;
 b=uIBa296Zd716+UkEbQMrqRhww6CWNno053ljWMLxmYgTHmBhQC8Rut4Q5XXruQ08NlF4
 bt09uEZb/kJRbceGEez8JDCQ+wt9iB5NEY2qeJT84QdLFIJG2J0jB9WaxFxBejHkhNpK
 DrXp8GAR8a6Ko78R3Xlp/qHJMt22OQLSxh116+mMMSL/L2eoCa5DUv3oEbBzh1I8Yiqy
 iSVdWj6O4x4lP0EeZud5sXENS3C4yf8J+dlIouphQPC2YEicpL4SX2nuLKI/hmLvtxtT
 PPT53Pk7apFr1agIYX2uAEw2OHKOrZ8povogNmn4JDyMZR1uIhdt18P0PGG5c0eVUVOe Mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 34hhvcpxc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 06 Nov 2020 01:50:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A61nqE8158252;
 Fri, 6 Nov 2020 01:50:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 34hvs1n6ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Nov 2020 01:50:32 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A61oTnw031822;
 Fri, 6 Nov 2020 01:50:29 GMT
Received: from [192.168.10.110] (/73.71.20.66)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Nov 2020 17:50:29 -0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v5] introduce vfio-user protocol specification
From: John G Johnson <john.g.johnson@oracle.com>
In-Reply-To: <MW2PR02MB3723F4DDEA3486981AAA9F088B100@MW2PR02MB3723.namprd02.prod.outlook.com>
Date: Thu, 5 Nov 2020 17:50:27 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1778D86-151D-4A67-9E2F-B49061A53FD3@oracle.com>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <20201028161005.115810-1-thanos.makatos@nutanix.com>
 <SN1PR02MB3725C85DCD4BF652FF6FBB8D8B170@SN1PR02MB3725.namprd02.prod.outlook.com>
 <20201030170306.GA2544852@li1368-133.members.linode.com>
 <MW2PR02MB3723D387485067C65D31D2328B100@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20201102114126.GA54031@li1368-133.members.linode.com>
 <MW2PR02MB3723F4DDEA3486981AAA9F088B100@MW2PR02MB3723.namprd02.prod.outlook.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060010
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=john.g.johnson@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 20:50:42
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 John Levon <levon@movementarian.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Nov 2, 2020, at 3:51 AM, Thanos Makatos =
<thanos.makatos@nutanix.com> wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: Qemu-devel <qemu-devel-
>> bounces+thanos.makatos=3Dnutanix.com@nongnu.org> On Behalf Of John
>> Levon
>> Sent: 02 November 2020 11:41
>> To: Thanos Makatos <thanos.makatos@nutanix.com>
>> Cc: benjamin.walker@intel.com; Elena Ufimtseva
>> <elena.ufimtseva@oracle.com>; jag.raman@oracle.com;
>> james.r.harris@intel.com; Swapnil Ingle <swapnil.ingle@nutanix.com>;
>> john.g.johnson@oracle.com; yuvalkashtan@gmail.com;
>> konrad.wilk@oracle.com; tina.zhang@intel.com; qemu-devel@nongnu.org;
>> dgilbert@redhat.com; Marc-Andr=C3=A9 Lureau
>> <marcandre.lureau@redhat.com>; ismael@linux.com;
>> alex.williamson@redhat.com; Stefan Hajnoczi <stefanha@redhat.com>;
>> Felipe Franciosi <felipe@nutanix.com>; xiuchun.lu@intel.com;
>> tomassetti.andrea@gmail.com; changpeng.liu@intel.com; Raphael Norwitz
>> <raphael.norwitz@nutanix.com>; Kanth.Ghatraju@oracle.com
>> Subject: Re: [PATCH v5] introduce vfio-user protocol specification
>>=20
>> On Mon, Nov 02, 2020 at 11:29:23AM +0000, Thanos Makatos wrote:
>>=20
>>>>=20
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>>>>> | version      | object | ``{"major": <number>, "minor": =
<number>}``
>> |
>>>>> |              |        |                                          =
         |
>>>>> |              |        | Version supported by the sender, e.g. =
"0.1".      |
>>>>=20
>>>> It seems quite unlikely but this should specify it's strings not =
floating point
>>>> values maybe?
>>>>=20
>>>> Definitely applies to max_fds too.
>>>=20
>>> major and minor are JSON numbers and specifically integers.
>>=20
>> It is debatable as to whether there is such a thing as a JSON integer =
:)
>=20
> AFAIK there isn't.
>=20
>>=20
>>> The rationale behind this is to simplify parsing. Is specifying that
>>> major/minor/max_fds should be an interger sufficient to clear any
>> vagueness
>>> here?
>>=20
>> I suppose that's OK as long as we never want a 0.1.1 or whatever. I'm =
not
>> sure
>> it simplifies parsing, but maybe it does.
>=20
> Now that you mention it, why preclude 0.1.1? IIUC the whole point of =
not
> stating the version as a float is to simply have this flexibility in =
the future.
> You're right in your earlier suggestion to explicitly state =
major/minor as
> strings.
>=20

	The idea behind the version IDs is to identify incompatible =
protocol
changes as major versions, and compatible changes as minor versions.  =
What
would be the purpose of the third version type?

	The thing that makes parsing the JSON easier is knowing the =
version
beforehand so the parser knows what keys to expect, so I=E2=80=99d like =
to promote
major and minor to separate fields in the packet from being embedded at =
an
arbitrary points in the JSON string.


>>=20
>>>>> Versioning and Feature Support
>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>> Upon accepting a connection, the server must send a
>> VFIO_USER_VERSION
>>>> message
>>>>> proposing a protocol version and a set of capabilities. The client
>> compares
>>>>> these with the versions and capabilities it supports and sends a
>>>>> VFIO_USER_VERSION reply according to the following rules.
>>>>=20
>>>> I'm curious if there was a specific reason it's this way around, =
when it
>> seems
>>>> more natural for the client to propose first, and the server to =
reply?
>>>=20
>>> I'm not aware of any specific reason.
>>=20
>> So can we switch it now so the initial setup is a send/recv too?
>=20
> I'm fine with that but would first like to hear back from John in case =
he objects.


	I think I write that section, and just switched client and =
server.  The code
is written as client proposes, server responds; this is the better =
model.

									=
JJ



