Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A77CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 04:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D120722B42
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 04:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fwcj8Ynv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D120722B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k10Vx-0002ae-03
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 00:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1k10VF-0002C6-Vs
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 00:49:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1k10VC-00034C-Fs
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 00:49:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U4kv5x099454;
 Thu, 30 Jul 2020 04:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=HO5LwIKPKfC7S5JZp6PXIMM3D17AwSG82YQGezhxxYY=;
 b=fwcj8YnvqH69igkWPr0ec0vR7qVKtIxInT6ofaXxfQfhkniCvvJORlfLiiwO9A1BnbO3
 arG2ypEsdmxcp8ba41wGfz/hTWkUhdRugAcVdUxhaI4lNnIkYNxhWqUfMFp3tFD0T7B+
 Df7SzyBjxPa19lnjA02sM+XeDy53JgmImLLv3l5Rmkl5qhaXZuEp4zxQ2AHa/hRdumtB
 DcvWigQLiF8SNtWEQcyvo1x1Skak6wEUbc+vKQtGnNRxwR2LhMBvrIEu1TqynnrzHuig
 5s3rTts5LYse5njE//6gfihAOoM0H43j9GGReljGT5fiKcc8gnHpxBwcOdoZ8N1iLchv RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 32hu1jhfe7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 04:49:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U4mWlL126189;
 Thu, 30 Jul 2020 04:48:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 32hu5yw2yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 04:48:59 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06U4mvmO015159;
 Thu, 30 Jul 2020 04:48:57 GMT
Received: from [192.168.10.3] (/24.5.35.151)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 29 Jul 2020 21:48:56 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] introduce VFIO-over-socket protocol specificaion
From: John G Johnson <john.g.johnson@oracle.com>
In-Reply-To: <20200729124803.GF37763@stefanha-x1.localdomain>
Date: Wed, 29 Jul 2020 21:48:54 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F43CA44-1616-4339-8C26-9B7B350C5BAB@oracle.com>
References: <1594913503-52271-1-git-send-email-thanos.makatos@nutanix.com>
 <20200717121753.GK128195@stefanha-x1.localdomain>
 <MW2PR02MB372306D4995774D4E6D036AD8B790@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200729124803.GF37763@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300035
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=john.g.johnson@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 00:49:04
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


	Thanos is on vacation.  My comments embedded.

					JJ



> On Jul 29, 2020, at 5:48 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>=20
> On Wed, Jul 22, 2020 at 11:42:26AM +0000, Thanos Makatos wrote:
>>>> diff --git a/docs/devel/vfio-over-socket.rst =
b/docs/devel/vfio-over-
>>> socket.rst
>>>> new file mode 100644
>>>> index 0000000..723b944
>>>> --- /dev/null
>>>> +++ b/docs/devel/vfio-over-socket.rst
>>>> @@ -0,0 +1,1135 @@
>>>> +***************************************
>>>> +VFIO-over-socket Protocol Specification
>>>> +***************************************
>>>> +
>>>> +Version 0.1
>>>=20
>>> Please include a reference to the section below explaining how
>>> versioning works.
>>=20
>> I'm not sure I understand, do you mean we should add something like =
the
>> following (right below "Version 0.1"):
>>=20
>> "Refer to section 1.2.3 on how versioning works."
>>=20
>> ?
>=20
> Yes, coming across this version number the reader has no idea about =
its
> meaning and how the protocol is versioned. The spec then moves on to
> other things. It would be helpful to reference the section that =
explains
> how versioning works so that the reader knows where to go to =
understand
> the meaning of the number.
>=20

	OK, we=E2=80=99ll add a forward reference


>>> What about the ordering semantics at the vfio-user protocol level? =
For
>>> example, if a client sends multiple VFIO_USER_DMA_MAP/UNMAP
>>> messages
>>> then the order matters. What are the rules? I wonder if maybe
>>> concurrency is a special case and really only applies to a subset of
>>> protocol commands?
>>=20
>> All commands are executed in the order they were sent, regardless of =
whether a
>> reply is needed.
>>=20
>>>=20
>>> I'm not sure how a client would exploit parallelism in this =
protocol.
>>> Can you give an example of a case where there would be multiple =
commands
>>> pending on a single device?
>>=20
>> For instance, a client can issue the following operations back to =
back without
>> waiting for the first two to complete:
>> 1. map a DMA region=20
>> 2. trigger some device-specific operation that results in data being =
read into
>>   that DMA region, and
>> 3. unmap the DMA region
>=20
> That is pipelining, but I don't see the ability to "reorder
> non-conflicting requests in parallel". That example has no =
parallelism.
>=20
> It's unclear to me what the spec means by concurrency and parallelism.
>=20
> If the intention is just to allow pipelining then request identifiers
> aren't really necessary. The client can keep track of which request =
will
> complete next. So I'm wondering if there is some parallelism somewhere
> that I'm missing=E2=80=A6
>=20

	The reason we have message IDs is so the client knows which =
request
is being acknowledged if it has more than one non-ack'd request =
outstanding.
Requests are executed in-order; the only time parallelism can happen is =
if
multiple client threads send requests in parallel.  A single thread can
pipeline requests, but those requests are not executed out of order by =
the
server.

	I=E2=80=99ll try to re-word it to be clearer.


>=20
>>>=20
>>>> +
>>>> +Socket Disconnection Behavior
>>>> +-----------------------------
>>>> +The server and the client can disconnect from each other, either
>>> intentionally
>>>> +or unexpectedly. Both the client and the server need to know how =
to
>>> handle such
>>>> +events.
>>>> +
>>>> +Server Disconnection
>>>> +^^^^^^^^^^^^^^^^^^^^
>>>> +A server disconnecting from the client may indicate that:
>>>> +
>>>> +1) A virtual device has been restarted, either intentionally (e.g. =
because of
>>> a
>>>> +device update) or unintentionally (e.g. because of a crash). In =
any case,
>>> the
>>>> +virtual device will come back so the client should not do anything =
(e.g.
>>> simply
>>>> +reconnect and retry failed operations).
>>>> +
>>>> +2) A virtual device has been shut down with no intention to be =
restarted.
>>>> +
>>>> +It is impossible for the client to know whether or not a failure =
is
>>>> +intermittent or innocuous and should be retried, therefore the =
client
>>> should
>>>> +attempt to reconnect to the socket. Since an intentional server =
restart
>>> (e.g.
>>>> +due to an upgrade) might take some time, a reasonable timeout =
should
>>> be used.
>>>> +In cases where the disconnection is expected (e.g. the guest =
shutting
>>> down), no
>>>> +new requests will be sent anyway so this situation doesn't pose a
>>> problem. The
>>>> +control stack will clean up accordingly.
>>>> +
>>>> +Parametrizing this behaviour by having the virtual device =
advertise a
>>>=20
>>> s/Parametrizing/Parameterizing/
>>=20
>> OK.
>>=20
>>>=20
>>>> +reasonable reconnect is deferred to a future version of the =
protocol.
>>>=20
>>> No mention is made of recovering state or how disconnect maps to =
VFIO
>>> device types (PCI, etc.). Does a disconnect mean that the device has
>>> been reset?
>>=20
>> Regarding recovering state, I believe that since all the building =
blocks are
>> there and the client is pretty much the master in the vfio-user =
model, it's up
>> to the client how to deal with exceptional situations. For recovery =
to work, the
>> client will have to reconfigure IRQs, DMAs, etc., and the server will =
have to
>> persistently store device state.
>>=20
>> Regarding how disconnect maps to VFIO device types, it depends on =
whether or not
>> the client/server can recover from it and continue operating. If this =
doesn't
>> happen (e.g. the server hasn't restarted, the client doesn't support
>> recovering), then the device cannot continue being operational, which =
I suppose
>> is an implementation detail of the client.
>>=20
>> Do we need something more specific at this stage?
>=20
> This sounds like implementation-defined behavior. If the spec does not
> cover this area then it might be hard to standardize it later without
> breaking existing implementations.
>=20
> Do you know how kernel VFIO behaves when the application is terminated
> unexpectedly?
>=20
> My intuition is that the device should be reset or at least fenced to
> discard all DMA immediately. With that as the default behavior the
> protocol could let implementations use protocol extensions for other
> recovery behavior.
>=20

	I=E2=80=99m not sure we=E2=80=99ll be able to improve on device =
reset, since
the client does not know what operations were completed before the
server died, and some region reads and writes may not be idempotent. =20

	I=E2=80=99d like to give Thanos a chance to reply before we =
commit to
a change.


>>>> +|              |        | Version supported by the sender, e.g.
>>> ???????0.1????????.      |
>>>> =
++--------------+--------+------------------------------------------------=
---+
>>>> +| type         | string | Fixed to ???????vfio-user????????.       =
                      |
>>>> =
++--------------+--------+------------------------------------------------=
---+
>>>> +| capabilities | array  | Reserved. Can be omitted for v0.1, =
otherwise must
>>> |
>>>> +|              |        | be empty.                                =
         |
>>>> =
++--------------+--------+------------------------------------------------=
---+
>>>=20
>>> s/array/array of strings/ ?
>>=20
>> No, it's array were each element can be any object in JSON.
>=20
> Okay. Maybe there is a way to be explicit by saying "untyped array" or
> adding "The type of the elements is not defined in this version of the
> specification" to the description.
>=20
>>=20
>>>=20
>>>> +
>>>> +Versioning and Feature Support
>>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> +Upon accepting a connection, the server must send a
>>> VFIO_USER_VERSION message
>>>> +proposing a protocol version and a set of capabilities. The client =
compares
>>>> +these with the versions and capabilities it supports and sends a
>>>> +VFIO_USER_VERSION reply according to the following rules.
>>>> +
>>>> +* The major version in the reply must be the same as proposed. If =
the
>>> client
>>>> +  does not support the proposed major, it closes the connection.
>>>> +* The minor version in the reply must be equal to or less than the =
minor
>>>> +  version proposed.
>>>> +* The capability list must be a subset of those proposed. If the =
client
>>>> +  requires a capability the server did not include, it closes the =
connection.
>>>> +* If type is not ???????vfio-user????????, the client closes the
>>> connection.
>>>=20
>>> Is there a rationale for this field? In order to get to the point =
where
>>> this JSON is parsed we must already implement the vfio-user protocol
>>> (e.g. parse the header).
>>=20
>> It was suggested to include it as a sanity check, we'll drop it.
>=20
> It's fine to keep it. Many protocols have a banner or identifier early
> on that requires some parsing. In this case it could be: this field
> makes it easy for humans decoding a protocol conversation to identify
> the protocol as vfio-user and also serves as a sanity check.
>=20

	I=E2=80=99d like to re-think the versioning a bit to avoid some =
of
the indeterminism.  I think it might be better to have the fields that
must exist to bootstrap the protocol (major & minor) be enumerated in
the version packet body.  Then, for each major/minor we can specify the
objects and their types that may exist in the JSON array.

	This list would initially only have the =E2=80=9Ctype=E2=80=9D =
string.



>>> What are the semantics of map/unmap with respect to mapping over
>>> existing regions, unmapping a subset of an existing region, etc?
>>=20
>> The VFIO kernel driver returns EEXIST if mapping over an existing =
area
>> and allows unmapping a subset. I'd think we should follow their =
example.
>=20
> Sounds good.
>=20
>>>=20
>>> What are the concerns for MAP/UNMAP while the device is operational =
and
>>> may be performing DMA? Should this command be combined into a single
>>> VFIO_USER_SET_DMA_REGIONS command with Flags Bit 1 indicating
>>> Add/Delete
>>> so that a single message can atomically add and delete DMA regions?
>>=20
>> Regarding receiving a DMA unmap request while there is an ongoing DMA
>> transaction, once the server ACK's the DMA unmap then it must not =
touch that DMA
>> region. It is an implementation detail whether the server waits for =
the DMA to
>> finish or kills the DMA operation, which might not be possible at all =
(e.g part
>> of that region has been submitted for I/O to a physical device).
>>=20
>>>=20
>>> What is the format of the reply to this message?
>>=20
>> It's just the header explained in the "Header" section, no additional =
data are
>> sent by the server, it simply ACK's the command.
>=20
> Okay, this was a little unclear to me when reading the spec. Maybe it
> would help to have a general explanation at the beginning stating that
> the message format is used by both the request and the reply unless
> stated otherwise.
>=20

	OK.

>>=20
>>>=20
>>>> +
>>>> +VFIO_USER_DEVICE_GET_INFO
>>>> +-------------------------
>>>> +
>>>> +Message format
>>>> +^^^^^^^^^^^^^^
>>>> +
>>>> ++--------------+----------------------------+
>>>> +| Name         | Value                      |
>>>> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>>>> +| Device ID    | <ID>                       |
>>>> ++--------------+----------------------------+
>>>> +| Message ID   | <ID>                       |
>>>> ++--------------+----------------------------+
>>>> +| Command      | 4                          |
>>>> ++--------------+----------------------------+
>>>> +| Message size | 16 in request, 32 in reply |
>>>> ++--------------+----------------------------+
>>>> +| Flags        | Reply bit set in reply     |
>>>> ++--------------+----------------------------+
>>>> +| Device info  | VFIO device info           |
>>>> ++--------------+----------------------------+
>>>> +
>>>> +This message is sent by the client to the server to query for =
basic
>>> information
>>>> +about the device. Only the message header is needed in the request
>>> message.
>>>> +The VFIO device info structure is defined in ``<sys/vfio.h>`` =
(``struct
>>>> +vfio_device_info``).
>>>> +
>>>> +VFIO device info format
>>>> +^^^^^^^^^^^^^^^^^^^^^^^
>>>> +
>>>> ++-------------+--------+--------------------------+
>>>> +| Name        | Offset | Size                     |
>>>> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+
>>>> +| argsz       | 16     | 4                        |
>>>> ++-------------+--------+--------------------------+
>>>> +| flags       | 20     | 4                        |
>>>> ++-------------+--------+--------------------------+
>>>> +|             | +-----+-------------------------+ |
>>>> +|             | | Bit | Definition              | |
>>>> +|             | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+ |
>>>> +|             | | 0   | VFIO_DEVICE_FLAGS_RESET | |
>>>> +|             | +-----+-------------------------+ |
>>>> +|             | | 1   | VFIO_DEVICE_FLAGS_PCI   | |
>>>> +|             | +-----+-------------------------+ |
>>>> ++-------------+--------+--------------------------+
>>>> +| num_regions | 24     | 4                        |
>>>> ++-------------+--------+--------------------------+
>>>> +| num_irqs    | 28     | 4                        |
>>>> ++-------------+--------+--------------------------+
>>>> +
>>>> +* argz is reserved in vfio-user, it is only used in the ioctl() =
VFIO
>>>> +  implementation.
>>>> +* flags contains the following device attributes.
>>>> +
>>>> +  * VFIO_DEVICE_FLAGS_RESET indicates the device supports the
>>>> +    VFIO_USER_DEVICE_RESET message.
>>>=20
>>> Why is VFIO_USER_DEVICE_RESET support optional?
>>=20
>> Because it is optional in VFIO, too.
>=20
> I see :D
>=20
>>>> +DMA Read/Write Data
>>>> +^^^^^^^^^^^^^^^^^^^
>>>> +
>>>> ++---------+--------+----------+
>>>> +| Name    | Offset | Size     |
>>>> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
>>>> +| Address | 16     | 8        |
>>>> ++---------+--------+----------+
>>>> +| Count   | 24     | 4        |
>>>> ++---------+--------+----------+
>>>> +| Data    | 28     | variable |
>>>> ++---------+--------+----------+
>>>> +
>>>> +* Address is the area of guest memory being accessed. This address =
must
>>> have
>>>> +  been exported to the server with a VFIO_USER_DMA_MAP message.
>>>> +* Count is the size of the data to be transferred.
>>>> +* Data is the data to be read or written.
>>>> +
>>>> +Address and count can also be accessed as ``struct iovec`` from
>>> ``<sys/uio.h>``.
>>>=20
>>> This seems to be incorrect since the count field is 4 bytes but =
struct
>>> iovec::iov_len is size_t (64-bit on 64-bit hosts).
>>=20
>> Indeed, I forgot about padding. We can remove the reference to struct =
iovec or
>> make count 8 bytes?
>=20
> I suggest removing the reference to struct iovec.

	OK




