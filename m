Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F1CC742C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDEB206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjw6PM4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDEB206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxFV-0002HP-67
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57201)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <flukshun@gmail.com>) id 1hlxFI-0001lu-Ju
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1hlxFH-0001l2-44
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:14:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>)
 id 1hlxFG-0001kp-Vp; Fri, 12 Jul 2019 11:13:59 -0400
Received: by mail-ot1-x342.google.com with SMTP id b7so9751192otl.11;
 Fri, 12 Jul 2019 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=Ronm4O6P/7UntzG3N24erW9NomskNCLCie1RtGNMJtU=;
 b=Gjw6PM4J5SwhBx0JxAGLvg5zyyJ+6NO41pvlecScW/fUPJhGSsu84K3EHfSQwWMLGH
 uYPXb8V+WpAe+/z2/ClpgzIty4gSur/C/p8QOy7UFRSDydexDBUl7hJBIMH/KZFQ8jgC
 C3TRvJgw+XFJAAeZ/tWbvybTIC0rQJ7opUb4sQGmaLHxQqLpk1W2RY5D+L6L+GgOK7L/
 TtcWYYZj8WOJFm2mDFqPkG8xd55pCOlvzjJ8w/7TJzL6wkg4W8Yb34LRwAAjrnAOMOO1
 h1VfJLPZ2xHmF3I6lgU8V6oLkqKl2PVkxaPL4yVZNXYFZ3XPjjq8QGosun9ULScfjRLH
 /Usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=Ronm4O6P/7UntzG3N24erW9NomskNCLCie1RtGNMJtU=;
 b=ixkRN2i4tXXQ3iwZejambGTztKG+KtHXowQ6DHV/DCdydeYPBOW30w+QKUre8IQOmc
 CP8FpOY/lKzph5G90+tiAN2vrnxSOkBIcEVAJHoQriA/e+YtkmqJmukb4yPYTfPaiWrQ
 TbGnjV/kJncbd7iXIjT8orJaqBE2A1fGXBlmL4cABjfwDt7F8SV0Hw+KNS1Yqv4Q38aK
 7JH+2GFy50Hnj1QlnDvXIlQ6BtJ5BDQo9rNSD7qqH3Tllm9gXK2vCK1A4MyBU1PFkYSA
 ZcxXHsUnCAz3ydZyyuhrHQPsDsnu2ImK+KsLA4nlg1rcbhbxBb1GUidHbk2E1Myh9Im6
 ABUw==
X-Gm-Message-State: APjAAAWEXNwEYUhKdk6zr9lBiq8FXrnZWUUJpXWVUW/1v1ZEQAStozHf
 sNy8CcWv92Bka/ukhz3LiAM=
X-Google-Smtp-Source: APXvYqwfh9ufuy4s8KWuhsrB7PGXsZTr93AD4z9f43oxszEsE/paQc9JCXHYobNmMhclZfi++sXB4w==
X-Received: by 2002:a9d:a76:: with SMTP id 109mr8299775otg.252.1562944437679; 
 Fri, 12 Jul 2019 08:13:57 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id b138sm3205104oii.7.2019.07.12.08.13.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Jul 2019 08:13:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: David Gibson <david@gibson.dropbear.id.au>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190712064027.GF2561@umbus.fritz.box>
References: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
 <20190712011934.29863-2-mdroth@linux.vnet.ibm.com>
 <20190712064027.GF2561@umbus.fritz.box>
Message-ID: <156294442813.22588.13951961791159970871@sif>
User-Agent: alot/0.7
Date: Fri, 12 Jul 2019 10:13:48 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 1/2] docs/specs: initial spec summary for
 Ultravisor-related hcalls
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
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting David Gibson (2019-07-12 01:40:27)
> On Thu, Jul 11, 2019 at 08:19:33PM -0500, Michael Roth wrote:
> > For now this only covers hcalls relating to TPM communication since
> > it's the only one particularly important from a QEMU perspective atm,
> > but others can be added here where it makes sense.
> > =

> > The full specification for all hcalls/ucalls will eventually be made
> > available in the public/OpenPower version of the PAPR specification.
> > =

> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> =

> Thanks for adding this documentation.  Is there a PAPR extension
> proposal which covers this, which we could cite as the source?

We have an internal document/repo that serves as a catch-all for the Ultrav=
isor
related spec changes. We could make that available publically via github and
cite it here until it hits the full spec. Would that work?

> =

> > ---
> >  docs/specs/ppc-spapr-uv-hcalls.txt | 74 ++++++++++++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 docs/specs/ppc-spapr-uv-hcalls.txt
> > =

> > diff --git a/docs/specs/ppc-spapr-uv-hcalls.txt b/docs/specs/ppc-spapr-=
uv-hcalls.txt
> > new file mode 100644
> > index 0000000000..0278f89190
> > --- /dev/null
> > +++ b/docs/specs/ppc-spapr-uv-hcalls.txt
> > @@ -0,0 +1,74 @@
> > +On PPC64 systems supporting Protected Execution Facility (PEF), system
> > +memory can be placed in a secured region where only an "ultravisor"
> > +running in firmware can provide to access it. pseries guests on such
> > +systems can communicate with the ultravisor (via ultracalls) to switch=
 to a
> > +secure VM mode (SVM) where the guest's memory is relocated to this sec=
ured
> > +region, making its memory inaccessible to normal processes/guests runn=
ing on
> > +the host.
> > +
> > +The various ultracalls/hypercalls relating to SVM mode are currently
> > +only documented internally, but are planned for direct inclusion into =
the
> > +public OpenPOWER version of the PAPR specification (LoPAPR/LoPAR). An =
internal
> > +ACR has been filed to reserve a hypercall number range specific to this
> > +use-case to avoid any future conflicts with the internally-maintained =
PAPR
> > +specification. This document summarizes some of these details as they =
relate
> > +to QEMU.
> > +
> > +=3D=3D hypercalls needed by the ultravisor =3D=3D
> > +
> > +Switching to SVM mode involves a number of hcalls issued by the ultrav=
isor
> > +to the hypervisor to orchestrate the movement of guest memory to secure
> > +memory and various other aspects SVM mode. The below documents the hca=
lls
> > +relevant to QEMU.
> > +
> > +- H_TPM_COMM (0xef10)
> > +
> > +  For TPM_COMM_OP_EXECUTE operation:
> > +    Send a request to a TPM and receive a response, opening a new TPM =
session
> > +    if one has not already been opened.
> > +
> > +  For TPM_COMM_OP_CLOSE_SESSION operation:
> > +    Close the existing TPM session, if any.
> > +
> > +  Arguments:
> > +
> > +    r3 : H_TPM_COMM (0xef10)
> > +    r4 : TPM operation, one of:
> > +         TPM_COMM_OP_EXECUTE (0x1)
> > +         TPM_COMM_OP_CLOSE_SESSION (0x2)
> > +    r5 : in_buffer, guest physical address of buffer containing the re=
quest
> > +         - Caller may use the same address for both request and respon=
se
> > +    r6 : in_size, size of the in buffer, must
> > +         - Must be less than or equal to 4KB
> > +    r7 : out_buffer, guest physical address of buffer to store the res=
ponse
> > +         - Caller may use the same address for both request and respon=
se
> > +    r8 : out_size, size of the out buffer
> > +         - Must be at least 4KB, as this is the maximum request/respon=
se size
> > +           supported by most TPM implementations, including the TPM Re=
source
> > +           Manager in the linux kernel.
> > +
> > +  Return values:
> > +
> > +    r3 : H_Success    request processed successfully
> > +         H_PARAMETER  invalid TPM operation
> > +         H_P2         in_buffer is invalid
> > +         H_P3         in_size is invalid
> > +         H_P4         out_buffer is invalid
> > +         H_P5         out_size is invalid
> > +         H_RESOURCE   TPM is unavailable
> > +    r4 : For TPM_COMM_OP_EXECUTE, the size of the response will be sto=
red here
> > +         upon success.
> > +
> > +  Use-case/notes:
> > +
> > +    SVM filesystems are encrypted using a symmetric key. This key is t=
hen
> > +    wrapped/encrypted using the public key of a trusted system which h=
as the
> > +    private key stored in the system's TPM. An Ultravisor will use this
> > +    hcall to unwrap/unseal the symmetric key using the system's TPM de=
vice
> > +    or a TPM Resource Manager associated with the device.
> > +
> > +    The Ultravisor sets up a separate session key with the TPM in adva=
nce
> > +    during host system boot. All sensitive in and out values will be
> > +    encrypted using the session key. Though the hypervisor will see th=
e 'in'
> > +    and 'out' buffers in raw form, any sensitive contents will general=
ly be
> > +    encrypted using this session key.
> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson

