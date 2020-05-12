Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A379CC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4A920675
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HfN1PI2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4A920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTjq-0005xt-Gh
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYTj3-0004zb-9v
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:09:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYTj1-0001JO-Ka
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:09:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CC343l144499;
 Tue, 12 May 2020 12:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=wGy1etcVnVyrfgRpTsbh55Lmr1h9ESAJyG1KeJ0LSas=;
 b=HfN1PI2GlkJRLq1uW/ZdK9WiN95SPVaaROYJCW+A3ckNaIlrw4c8rWMktcEnPAtQCFz/
 c1dF/bL7riGCP8GOUH97NPhkf6BDx6C54sIVNMz8XOyzyC4FasJnlME5q/v1o9fRqOUv
 2TN+FZGFxT8C/1vp2YMTbKIKQ6pE5uif/BFVdxtzUcJWgIoOvND3ibuBtc4j8aHripVv
 pJKNu6blk9GU861p+GKMbwaGdJM6w41MToJxBN7QpLJINp6OPG/YQxnbBqj907whB1Wy
 V3eh6xsWnho4igv7Wq6ueJADQ58riFiPM0/MtpCF0vZ6ivdFnxcMT4WBRmwqvaS3/zFa mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 30x3mbthgu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 12:09:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CC8Woc164557;
 Tue, 12 May 2020 12:09:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 30xbgjc7sk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 12:09:21 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04CC9GY4018596;
 Tue, 12 May 2020 12:09:16 GMT
Received: from dhcp-10-39-202-98.vpn.oracle.com (/10.39.202.98)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 05:09:16 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH RESEND v6 11/36] multi-process: define mpqemu-link object
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200512085636.GB300009@stefanha-x1.localdomain>
Date: Tue, 12 May 2020 08:09:13 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <700BF12A-8D49-46C7-BA7D-9ADA3BBBD979@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <8ffca5a79b71ebe0f183707db34f59562faee71f.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512085636.GB300009@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=3 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=3 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120091
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 08:09:29
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 swapnil.ingle@nutanix.com, John G Johnson <john.g.johnson@oracle.com>,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On May 12, 2020, at 4:56 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Wed, Apr 22, 2020 at 09:13:46PM -0700, elena.ufimtseva@oracle.com =
wrote:
>> From: Jagannathan Raman <jag.raman@oracle.com>
>>=20
>> Defines mpqemu-link object which forms the communication link between
>> QEMU & emulation program.
>> Adds functions to configure members of mpqemu-link object instance.
>> Adds functions to send and receive messages over the communication
>> channel.
>> Adds GMainLoop to handle events received on the communication =
channel.
>>=20
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> This will change a lot when integrated into the QEMU event loop so =
I've
> skipped a lot of the code.
>=20
> QIOChannel is probably the appropriate object to use instead of =
directly
> accessing a file descriptor.

OK, got it. Thanks!

>=20
>> +/**
>> + * mpqemu_cmd_t:
>> + *
>> + * proc_cmd_t enum type to specify the command to be executed on the =
remote
>> + * device.
>> + */
>> +typedef enum {
>> +    INIT =3D 0,
>> +    MAX,
>> +} mpqemu_cmd_t;
>> +
>> +/**
>> + * MPQemuMsg:
>> + * @cmd: The remote command
>> + * @bytestream: Indicates if the data to be shared is structured =
(data1)
>> + *              or unstructured (data2)
>> + * @size: Size of the data to be shared
>> + * @data1: Structured data
>> + * @fds: File descriptors to be shared with remote device
>> + * @data2: Unstructured data
>> + *
>> + * MPQemuMsg Format of the message sent to the remote device from =
QEMU.
>> + *
>> + */
>> +typedef struct {
>> +    mpqemu_cmd_t cmd;
>=20
> Please use an int field on the wire because the C standard says:
>=20
>  Each enumerated type shall be compatible with char, a signed integer
>  type, or an unsigned integer type. The choice of type is
>  implementation-defined, but shall be capable of representing the
>  values of all the members of the enumeration.
>=20
> So the compiler may make this a char field (which would introduce
> padding before the bytestream field) but if a new enum constant FOO =3D
> 0x100 is added then the compiler might change the size to 16-bit.
>=20
>> +int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *chan)
>> +{
>> +    int rc;
>> +    uint8_t *data;
>> +    union {
>> +        char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
>> +        struct cmsghdr align;
>> +    } u;
>> +    struct msghdr hdr;
>> +    struct cmsghdr *chdr;
>> +    size_t fdsize;
>> +    int sock =3D chan->sock;
>> +    QemuMutex *lock =3D &chan->recv_lock;
>> +
>> +    struct iovec iov =3D {
>> +        .iov_base =3D (char *) msg,
>> +        .iov_len =3D MPQEMU_MSG_HDR_SIZE,
>> +    };
>> +
>> +    memset(&hdr, 0, sizeof(hdr));
>> +    memset(&u, 0, sizeof(u));
>> +
>> +    hdr.msg_iov =3D &iov;
>> +    hdr.msg_iovlen =3D 1;
>> +    hdr.msg_control =3D &u;
>> +    hdr.msg_controllen =3D sizeof(u);
>> +
>> +    WITH_QEMU_LOCK_GUARD(lock) {
>> +        do {
>> +            rc =3D recvmsg(sock, &hdr, 0);
>> +        } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D =
EAGAIN));
>> +
>> +        if (rc < 0) {
>=20
> Missing rc !=3D MPQEMU_MSG_HDR_SIZE check. If this was a short read we
> should not attempt to parse uninitialized bytes in msg.
>=20
> This is more defensive than relying on catching bogus input values =
later
> on and also protects against accidentally revealing uninitialized =
memory
> contents by observing our error handling response.
>=20
>> +            qemu_log_mask(LOG_REMOTE_DEBUG, "%s - recvmsg rc is %d, =
"
>> +                          "errno is %d, sock %d\n", __func__, rc, =
errno, sock);
>> +            return rc;
>> +        }
>> +
>> +        msg->num_fds =3D 0;
>> +        for (chdr =3D CMSG_FIRSTHDR(&hdr); chdr !=3D NULL;
>> +             chdr =3D CMSG_NXTHDR(&hdr, chdr)) {
>> +            if ((chdr->cmsg_level =3D=3D SOL_SOCKET) &&
>> +                (chdr->cmsg_type =3D=3D SCM_RIGHTS)) {
>> +                fdsize =3D chdr->cmsg_len - CMSG_LEN(0);
>> +                msg->num_fds =3D fdsize / sizeof(int);
>> +                if (msg->num_fds > REMOTE_MAX_FDS) {
>> +                    qemu_log_mask(LOG_REMOTE_DEBUG,
>> +                                  "%s: Max FDs exceeded\n", =
__func__);
>> +                    return -ERANGE;
>> +                }
>> +
>> +                memcpy(msg->fds, CMSG_DATA(chdr), fdsize);
>> +                break;
>> +            }
>> +        }
>> +
>> +        if (msg->bytestream) {
>> +            if (!msg->size) {
>> +                qemu_mutex_unlock(lock);
>=20
> Duplicate unlock, we're already inside WITH_QEMU_LOCK_GUARD().
>=20
>> +                return -EINVAL;
>> +            }
>> +
>> +            msg->data2 =3D calloc(1, msg->size);
>=20
> What is the maximum message size? Please pick one and enforce it to
> protect against huge allocations that cause us to run out of memory.
>=20
>> +            data =3D msg->data2;
>> +        } else {
>> +            data =3D (uint8_t *)&msg->data1;
>=20
> Adding a uint8_t member to the union eliminates the need for a cast:
>=20
>  union {
>      uint64_t u64;
>      uint8_t u8;
>  } data1;
>=20
>  ...
>=20
>  data =3D &msg->data1.u8;
>=20
>> +        }
>> +
>> +        if (msg->size) {
>> +            do {
>> +                rc =3D read(sock, data, msg->size);
>> +            } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D =
EAGAIN));
>> +        }
>=20
> Short reads are an error. Please check that the sum of rc values is
> equal to msg->size.
>=20
>> +    }
>> +    return rc;
>> +}
> ...
>> +bool mpqemu_msg_valid(MPQemuMsg *msg)
>> +{
>> +    if (msg->cmd >=3D MAX) {
>> +        return false;
>> +    }
>=20
> Checking msg->cmd < 0 is also useful here, especially when the field
> type is changed to int.


