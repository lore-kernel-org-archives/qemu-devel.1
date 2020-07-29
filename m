Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254BDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D1720829
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCCBGjVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D1720829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0lW1-00044X-6E
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 08:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0lVB-0003Yw-JW
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:48:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0lV9-0003qd-Be
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:48:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id k8so2833895wma.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=I9EXQxN7YeQrJMCVoO4q6htgboEUSfHxHD6Bfc/UG7w=;
 b=ZCCBGjVGJS2SKhXiAIKTe5oNrl29pcK9Nxhl3A4pZpqk0CuqBeL/cjPPdwG5Kw1SsV
 Mlf89EvqP5kH2/Un0uEk9laUYE7IrxQ5EkMqgRumqjbLGDdstArl/VoyiR9sgT8PrcHz
 0GDOdxELsR6mTeehJCRMNwZtFxv7IbFHhIVB9nfqtuMWJ2ajqCh8fY3x2zNwbAMwY1RD
 Wh3SHV4xnv+nb/TXn0T0Xc+3xWeZHTD9VqodfH9kHNKk7JhllkiS5NN1hrlVxV3PUoDU
 +n22JJuUK0+i6PRVsIvVhnnKeSu5S/9MFKiE5NjmUAS88XPVEoBQqwufrdcrnZxemUco
 8ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I9EXQxN7YeQrJMCVoO4q6htgboEUSfHxHD6Bfc/UG7w=;
 b=hNq+a8NqdLC7NhRruLl33/u+4N69KkELniP/3Jv5UFTSe2SgAm93WXMkj1TsPOR10s
 CMGjrLgFqIg6ObBaB/Ep+YgtKDTFQBOseCLLLfx9VLnzwxA2tVrkeXgHPGKY0ZT31yx6
 20k+/PHqr8x0wkDhy8ubzfrlXV+cUescTpJ3w+HbaN9RBqrV2qbmo2vnAzjeKJ4fY3Ve
 0PU455ecUr2z3xwfJ21BN+B6xel5lDd0s3fvQaJQVTbccfzIN8Fis8ycFoBWCqjoDlyw
 bS3HW1YjjU6nbbVIMq3/B8xDG9nbe8T1VziyO4v7f/bkwekLOdhgZeedD98IiDa5WxIM
 a07Q==
X-Gm-Message-State: AOAM53122mRqbb/6H+nxOVQfMj45ubCMEeKRsY4DnjtWSjdfFqZmAcYH
 aRf/OdulFxTWTY5VpBTuWNo=
X-Google-Smtp-Source: ABdhPJzM4lXNMUJNYggdLkK9dKp7EacrXQbw9n3BlVkP7JorGwVWaRfIpiR6qgWujbSoSGm+e9VQhg==
X-Received: by 2002:a1c:e302:: with SMTP id a2mr8963724wmh.110.1596026885618; 
 Wed, 29 Jul 2020 05:48:05 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 130sm5551856wme.26.2020.07.29.05.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 05:48:04 -0700 (PDT)
Date: Wed, 29 Jul 2020 13:48:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH] introduce VFIO-over-socket protocol specificaion
Message-ID: <20200729124803.GF37763@stefanha-x1.localdomain>
References: <1594913503-52271-1-git-send-email-thanos.makatos@nutanix.com>
 <20200717121753.GK128195@stefanha-x1.localdomain>
 <MW2PR02MB372306D4995774D4E6D036AD8B790@MW2PR02MB3723.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Pgaa2uWPnPrfixyx"
Content-Disposition: inline
In-Reply-To: <MW2PR02MB372306D4995774D4E6D036AD8B790@MW2PR02MB3723.namprd02.prod.outlook.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Pgaa2uWPnPrfixyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 11:42:26AM +0000, Thanos Makatos wrote:
> > > diff --git a/docs/devel/vfio-over-socket.rst b/docs/devel/vfio-over-
> > socket.rst
> > > new file mode 100644
> > > index 0000000..723b944
> > > --- /dev/null
> > > +++ b/docs/devel/vfio-over-socket.rst
> > > @@ -0,0 +1,1135 @@
> > > +***************************************
> > > +VFIO-over-socket Protocol Specification
> > > +***************************************
> > > +
> > > +Version 0.1
> >=20
> > Please include a reference to the section below explaining how
> > versioning works.
>=20
> I'm not sure I understand, do you mean we should add something like the
> following (right below "Version 0.1"):
>=20
> "Refer to section 1.2.3 on how versioning works."
>=20
> ?

Yes, coming across this version number the reader has no idea about its
meaning and how the protocol is versioned. The spec then moves on to
other things. It would be helpful to reference the section that explains
how versioning works so that the reader knows where to go to understand
the meaning of the number.

> > What about the ordering semantics at the vfio-user protocol level? For
> > example, if a client sends multiple VFIO_USER_DMA_MAP/UNMAP
> > messages
> > then the order matters. What are the rules? I wonder if maybe
> > concurrency is a special case and really only applies to a subset of
> > protocol commands?
>=20
> All commands are executed in the order they were sent, regardless of whet=
her a
> reply is needed.
>=20
> >=20
> > I'm not sure how a client would exploit parallelism in this protocol.
> > Can you give an example of a case where there would be multiple commands
> > pending on a single device?
>=20
> For instance, a client can issue the following operations back to back wi=
thout
> waiting for the first two to complete:
> 1. map a DMA region=20
> 2. trigger some device-specific operation that results in data being read=
 into
>    that DMA region, and
> 3. unmap the DMA region

That is pipelining, but I don't see the ability to "reorder
non-conflicting requests in parallel". That example has no parallelism.

It's unclear to me what the spec means by concurrency and parallelism.

If the intention is just to allow pipelining then request identifiers
aren't really necessary. The client can keep track of which request will
complete next. So I'm wondering if there is some parallelism somewhere
that I'm missing...


> >=20
> > > +
> > > +Socket Disconnection Behavior
> > > +-----------------------------
> > > +The server and the client can disconnect from each other, either
> > intentionally
> > > +or unexpectedly. Both the client and the server need to know how to
> > handle such
> > > +events.
> > > +
> > > +Server Disconnection
> > > +^^^^^^^^^^^^^^^^^^^^
> > > +A server disconnecting from the client may indicate that:
> > > +
> > > +1) A virtual device has been restarted, either intentionally (e.g. b=
ecause of
> > a
> > > +device update) or unintentionally (e.g. because of a crash). In any =
case,
> > the
> > > +virtual device will come back so the client should not do anything (=
e.g.
> > simply
> > > +reconnect and retry failed operations).
> > > +
> > > +2) A virtual device has been shut down with no intention to be resta=
rted.
> > > +
> > > +It is impossible for the client to know whether or not a failure is
> > > +intermittent or innocuous and should be retried, therefore the client
> > should
> > > +attempt to reconnect to the socket. Since an intentional server rest=
art
> > (e.g.
> > > +due to an upgrade) might take some time, a reasonable timeout should
> > be used.
> > > +In cases where the disconnection is expected (e.g. the guest shutting
> > down), no
> > > +new requests will be sent anyway so this situation doesn't pose a
> > problem. The
> > > +control stack will clean up accordingly.
> > > +
> > > +Parametrizing this behaviour by having the virtual device advertise a
> >=20
> > s/Parametrizing/Parameterizing/
>=20
> OK.
>=20
> >=20
> > > +reasonable reconnect is deferred to a future version of the protocol.
> >=20
> > No mention is made of recovering state or how disconnect maps to VFIO
> > device types (PCI, etc.). Does a disconnect mean that the device has
> > been reset?
>=20
> Regarding recovering state, I believe that since all the building blocks =
are
> there and the client is pretty much the master in the vfio-user model, it=
's up
> to the client how to deal with exceptional situations. For recovery to wo=
rk, the
> client will have to reconfigure IRQs, DMAs, etc., and the server will hav=
e to
> persistently store device state.
>=20
> Regarding how disconnect maps to VFIO device types, it depends on whether=
 or not
> the client/server can recover from it and continue operating. If this doe=
sn't
> happen (e.g. the server hasn't restarted, the client doesn't support
> recovering), then the device cannot continue being operational, which I s=
uppose
> is an implementation detail of the client.
>=20
> Do we need something more specific at this stage?

This sounds like implementation-defined behavior. If the spec does not
cover this area then it might be hard to standardize it later without
breaking existing implementations.

Do you know how kernel VFIO behaves when the application is terminated
unexpectedly?

My intuition is that the device should be reset or at least fenced to
discard all DMA immediately. With that as the default behavior the
protocol could let implementations use protocol extensions for other
recovery behavior.

> > > +|              |        | Version supported by the sender, e.g.
> > ???????0.1????????.      |
> > > ++--------------+--------+-------------------------------------------=
--------+
> > > +| type         | string | Fixed to ???????vfio-user????????.        =
                     |
> > > ++--------------+--------+-------------------------------------------=
--------+
> > > +| capabilities | array  | Reserved. Can be omitted for v0.1, otherwi=
se must
> > |
> > > +|              |        | be empty.                                 =
        |
> > > ++--------------+--------+-------------------------------------------=
--------+
> >=20
> > s/array/array of strings/ ?
>=20
> No, it's array were each element can be any object in JSON.

Okay. Maybe there is a way to be explicit by saying "untyped array" or
adding "The type of the elements is not defined in this version of the
specification" to the description.

>=20
> >=20
> > > +
> > > +Versioning and Feature Support
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +Upon accepting a connection, the server must send a
> > VFIO_USER_VERSION message
> > > +proposing a protocol version and a set of capabilities. The client c=
ompares
> > > +these with the versions and capabilities it supports and sends a
> > > +VFIO_USER_VERSION reply according to the following rules.
> > > +
> > > +* The major version in the reply must be the same as proposed. If the
> > client
> > > +  does not support the proposed major, it closes the connection.
> > > +* The minor version in the reply must be equal to or less than the m=
inor
> > > +  version proposed.
> > > +* The capability list must be a subset of those proposed. If the cli=
ent
> > > +  requires a capability the server did not include, it closes the co=
nnection.
> > > +* If type is not ???????vfio-user????????, the client closes the
> > connection.
> >=20
> > Is there a rationale for this field? In order to get to the point where
> > this JSON is parsed we must already implement the vfio-user protocol
> > (e.g. parse the header).
>=20
> It was suggested to include it as a sanity check, we'll drop it.

It's fine to keep it. Many protocols have a banner or identifier early
on that requires some parsing. In this case it could be: this field
makes it easy for humans decoding a protocol conversation to identify
the protocol as vfio-user and also serves as a sanity check.

> > What are the semantics of map/unmap with respect to mapping over
> > existing regions, unmapping a subset of an existing region, etc?
>=20
> The VFIO kernel driver returns EEXIST if mapping over an existing area
> and allows unmapping a subset. I'd think we should follow their example.

Sounds good.

> >=20
> > What are the concerns for MAP/UNMAP while the device is operational and
> > may be performing DMA? Should this command be combined into a single
> > VFIO_USER_SET_DMA_REGIONS command with Flags Bit 1 indicating
> > Add/Delete
> > so that a single message can atomically add and delete DMA regions?
>=20
> Regarding receiving a DMA unmap request while there is an ongoing DMA
> transaction, once the server ACK's the DMA unmap then it must not touch t=
hat DMA
> region. It is an implementation detail whether the server waits for the D=
MA to
> finish or kills the DMA operation, which might not be possible at all (e.=
g part
> of that region has been submitted for I/O to a physical device).
>=20
> >=20
> > What is the format of the reply to this message?
>=20
> It's just the header explained in the "Header" section, no additional dat=
a are
> sent by the server, it simply ACK's the command.

Okay, this was a little unclear to me when reading the spec. Maybe it
would help to have a general explanation at the beginning stating that
the message format is used by both the request and the reply unless
stated otherwise.

>=20
> >=20
> > > +
> > > +VFIO_USER_DEVICE_GET_INFO
> > > +-------------------------
> > > +
> > > +Message format
> > > +^^^^^^^^^^^^^^
> > > +
> > > ++--------------+----------------------------+
> > > +| Name         | Value                      |
> > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > > +| Device ID    | <ID>                       |
> > > ++--------------+----------------------------+
> > > +| Message ID   | <ID>                       |
> > > ++--------------+----------------------------+
> > > +| Command      | 4                          |
> > > ++--------------+----------------------------+
> > > +| Message size | 16 in request, 32 in reply |
> > > ++--------------+----------------------------+
> > > +| Flags        | Reply bit set in reply     |
> > > ++--------------+----------------------------+
> > > +| Device info  | VFIO device info           |
> > > ++--------------+----------------------------+
> > > +
> > > +This message is sent by the client to the server to query for basic
> > information
> > > +about the device. Only the message header is needed in the request
> > message.
> > > +The VFIO device info structure is defined in ``<sys/vfio.h>`` (``str=
uct
> > > +vfio_device_info``).
> > > +
> > > +VFIO device info format
> > > +^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > ++-------------+--------+--------------------------+
> > > +| Name        | Offset | Size                     |
> > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+
> > > +| argsz       | 16     | 4                        |
> > > ++-------------+--------+--------------------------+
> > > +| flags       | 20     | 4                        |
> > > ++-------------+--------+--------------------------+
> > > +|             | +-----+-------------------------+ |
> > > +|             | | Bit | Definition              | |
> > > +|             | +=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+ |
> > > +|             | | 0   | VFIO_DEVICE_FLAGS_RESET | |
> > > +|             | +-----+-------------------------+ |
> > > +|             | | 1   | VFIO_DEVICE_FLAGS_PCI   | |
> > > +|             | +-----+-------------------------+ |
> > > ++-------------+--------+--------------------------+
> > > +| num_regions | 24     | 4                        |
> > > ++-------------+--------+--------------------------+
> > > +| num_irqs    | 28     | 4                        |
> > > ++-------------+--------+--------------------------+
> > > +
> > > +* argz is reserved in vfio-user, it is only used in the ioctl() VFIO
> > > +  implementation.
> > > +* flags contains the following device attributes.
> > > +
> > > +  * VFIO_DEVICE_FLAGS_RESET indicates the device supports the
> > > +    VFIO_USER_DEVICE_RESET message.
> >=20
> > Why is VFIO_USER_DEVICE_RESET support optional?
>=20
> Because it is optional in VFIO, too.

I see :D

> > > +DMA Read/Write Data
> > > +^^^^^^^^^^^^^^^^^^^
> > > +
> > > ++---------+--------+----------+
> > > +| Name    | Offset | Size     |
> > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+
> > > +| Address | 16     | 8        |
> > > ++---------+--------+----------+
> > > +| Count   | 24     | 4        |
> > > ++---------+--------+----------+
> > > +| Data    | 28     | variable |
> > > ++---------+--------+----------+
> > > +
> > > +* Address is the area of guest memory being accessed. This address m=
ust
> > have
> > > +  been exported to the server with a VFIO_USER_DMA_MAP message.
> > > +* Count is the size of the data to be transferred.
> > > +* Data is the data to be read or written.
> > > +
> > > +Address and count can also be accessed as ``struct iovec`` from
> > ``<sys/uio.h>``.
> >=20
> > This seems to be incorrect since the count field is 4 bytes but struct
> > iovec::iov_len is size_t (64-bit on 64-bit hosts).
>=20
> Indeed, I forgot about padding. We can remove the reference to struct iov=
ec or
> make count 8 bytes?

I suggest removing the reference to struct iovec.

--Pgaa2uWPnPrfixyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hcAMACgkQnKSrs4Gr
c8jrsgf8D/MfF0rXbr32sbWqgDeH1WpSdympL++Vpp8rS2zcplA5JI0/My1Ian7b
3pGm2MztVh+jXk9zKR/DU8jZvrKTw4UAFyeKJqlBXzOb+pwvgSSnb8nqFupa/Z8y
gNlb6eTN6oE6glHwBySgrXSQEJYvXSzszTl7A8wUnp2GzlcXEXWybUa6EsRt3DRS
usP3DUTw3U8oGj9Rq9oZh3a26H/a+PpU3lUEO9e/4AmkIZg/Lc7oKyd/ipEnJqV9
EWgLIvxpHDAPYyu2iSJnTlRCGQgX23+NFX+zEr3fvFQrGcbvxBXBFSirTVajYnXV
Dz6BgRm9zXv9lfF13MAMPb4nbQjGqg==
=C42B
-----END PGP SIGNATURE-----

--Pgaa2uWPnPrfixyx--

