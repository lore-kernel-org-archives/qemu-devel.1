Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E6BC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA1B20731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR+m7zUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA1B20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUB6y-0003jy-6a
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 11:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUB3F-0006le-GL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUB0d-0001wI-Ag
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:24:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51016
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUB0c-0001rp-Om
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588260113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+n+Pnvffg2Z3NzDSEEWCxeVaiGC1LfTknk34MXcGlSA=;
 b=NR+m7zURpSQOLE7M8x+iGe4C1HEiU2AEthywQd9DrxQZRZEaGDbiddgE5dqkkPhv/NGgne
 kRF1kuTP9NlNFdhABN36l5Cn3459bD5vasQLhbduoHE1F1Hh4WnfdLzggpbeNktMwzsBKB
 8jGSaCRP7EVpKROW+QUY8QA5eJmHLFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-sEFBUv38Psico5PzdyPxYQ-1; Thu, 30 Apr 2020 11:21:49 -0400
X-MC-Unique: sEFBUv38Psico5PzdyPxYQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19B79EC1AD;
 Thu, 30 Apr 2020 15:21:48 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33C725D9C5;
 Thu, 30 Apr 2020 15:21:47 +0000 (UTC)
Subject: Re: [PATCH v2 3/6] qemu-img: Add bitmap sub-command
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-4-eblake@redhat.com>
 <1dcf85b6-d9e6-b952-537c-791daec34ad9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9d4769d4-09ea-dced-d4bd-9ceb33044202@redhat.com>
Date: Thu, 30 Apr 2020 10:21:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1dcf85b6-d9e6-b952-537c-791daec34ad9@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 9:55 AM, Max Reitz wrote:
> On 21.04.20 23:20, Eric Blake wrote:
>> Include actions for --add, --remove, --clear, --enable, --disable, and
>> --merge (note that --clear is a bit of fluff, because the same can be
>> accomplished by removing a bitmap and then adding a new one in its
>> place,
>=20
> Well, ideally, all of qemu-img is just fluff because =E2=80=9Cthe same ca=
n be
> accomplished by launching qemu and issuing the equivalent QMP commands=E2=
=80=9D. :)
>=20
>>         but it matches what QMP commands exist).  Listing is omitted,
>> because it does not require a bitmap name and because it was already
>> possible with 'qemu-img info'.
>=20
> Fair enough, although it can be said that qemu-img info=E2=80=99s output =
is
> qcow2-specific.  It might be nice to have some definitely
> format-independent output.  (But we don=E2=80=99t have persistent bitmaps=
 in
> anything but qcow2 yet (or do we in NBD?), so I don=E2=80=99t expect anyo=
ne to
> care much.)

We can add a list subcommand later if it is still desired.  I agree that=20
a tabular format:

name          enabled   granularity
bitmap1       false     65536
bitmap2       true      512

in isolation is easier to read than:

     bitmaps:
         [0]:
             flags:
             name: bitmap1
             granularity: 65536
         [1]:
             flags:
                 [0]: auto
             name: bitmap2
             granularity: 512

embedded inside even more information.

>=20
>>                                  Merge can work either from another
>> bitmap in the same image, or from a bitmap in a distinct image.
>>
>> While this supports --image-opts for the file being modified, I did
>> not think it worth the extra complexity to support that for the source
>> file in a cross-file bitmap merge.  Likewise, I chose to have --merge
>> only take a single source rather than following the QMP support for
>> multiple merges in one go; in part to simplify the command line, and
>> in part because an offline image can achieve the same effect by
>> multiple qemu-img bitmap --merge calls.  We can enhance that if needed
>> in the future (the same way that 'qemu-img convert' has a mode that
>> concatenates multiple sources into one destination).
>>
>> Upcoming patches will add iotest coverage of these commands while
>> also testing other features.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   docs/tools/qemu-img.rst |  24 +++++
>>   qemu-img.c              | 198 ++++++++++++++++++++++++++++++++++++++++
>>   qemu-img-cmds.hx        |   7 ++
>>   3 files changed, 229 insertions(+)
>>
>> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
>> index 7d08c48d308f..4f3b0e2c9ace 100644
>> --- a/docs/tools/qemu-img.rst
>> +++ b/docs/tools/qemu-img.rst
>> @@ -281,6 +281,30 @@ Command description:
>>     For write tests, by default a buffer filled with zeros is written. T=
his can be
>>     overridden with a pattern byte specified by *PATTERN*.
>>
>> +.. option:: bitmap {--add [-g GRANULARITY] [--disabled] | --remove | --=
clear | --enable | --disable | --merge SOURCE_BITMAP [-b SOURCE_FILE [-F SO=
URCE_FMT]]} [--object OBJECTDEF] [--image-opts] [-f FMT] FILENAME BITMAP
>=20
> So I can do multiple operations in one roll, but they all use the same
> BITMAP?  Sounds a bit weird.  It actually took me a while to understands
> this, because I thought for sure that each command would take a bitmap
> name.  (And was ready to complain that it looked like they don=E2=80=99t,=
 but,
> well, that=E2=80=99s because they don=E2=80=99t.)

All of the operations take one bitmap name (the final BITMAP).=20
Additionally, the --merge operation takes a second bitmap name=20
(SOURCE_BITMAP).  None of the other operations need a second bitmap=20
name, so only --merge requires an option argument.  As written, the { a=20
| b | c } implies that operations are mutually exclusive: you can only=20
request one operation per qemu-img invocation.

>=20
> Although I suppose some practical example like
>=20
> $ qemu-img bitmap --add --merge sbmap --disable foo.qcow2 nbmap
>=20
> does make sense.[1]
>=20
>=20
> Would
>=20
> $ qemu-img bitmap --add nbmap --merge nbmap sbmap --enable nbmap \
>        foo.qcow2
>=20
> make more sense?

That would be more transactional, and more effort to implement.  My=20
argument is that you should instead write:

$ qemu-img bitmap --add foo.qcow2 nbmap
$ qemu-img bitmap --merge sbmap foo.qcow2 nbmap
$ qemu-img bitmap --enable foo.qcow2 nbmap

where I only have to implement one operation per qemu-img.

>    Doesn=E2=80=99t really look like it, because at that point you
> just have to ask why not just call qemu-img bitmap multiple times.
>=20
> *shrug*
>=20
>=20
> [1] However, that leads me to ask:  Why does --add need a --disabled
> option?  Isn=E2=80=99t that equivalent to --add --disable?

The QMP command for add has an optional 'disabled' parameter, which I=20
exposed here.  Alternatively, we could indeed NOT expose that parameter=20
through qemu-img, but require two separate qemu-img bitmap commands to=20
add and then disable things.  Atomicity is not a concern here like it=20
was in QMP.  Removing that sugar does simplify things slightly.


>> +static int img_bitmap(int argc, char **argv)
>> +{
>> +    Error *err =3D NULL;
>> +    int c, ret =3D -1;
>> +    QemuOpts *opts =3D NULL;
>> +    const char *fmt =3D NULL, *src_fmt =3D NULL, *src_filename =3D NULL=
;
>> +    const char *filename, *bitmap;
>> +    BlockBackend *blk =3D NULL, *src =3D NULL;
>> +    BlockDriverState *bs =3D NULL, *src_bs =3D NULL;
>> +    bool image_opts =3D false;
>> +    unsigned long granularity =3D 0;
>> +    bool add =3D false, remove =3D false, clear =3D false;
>> +    bool enable =3D false, disable =3D false, add_disabled =3D false;
>> +    const char *merge =3D NULL;
>=20
> So actually we can=E2=80=99t do one operation multiple times in one roll.

Correct.  At least, not as I wrote it.

>=20
>> +
>> +    for (;;) {
>> +        static const struct option long_options[] =3D {
>> +            {"help", no_argument, 0, 'h'},
>> +            {"object", required_argument, 0, OPTION_OBJECT},
>> +            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
>> +            {"add", no_argument, 0, OPTION_ADD},
>> +            {"remove", no_argument, 0, OPTION_REMOVE},
>> +            {"clear", no_argument, 0, OPTION_CLEAR},
>> +            {"enable", no_argument, 0, OPTION_ENABLE},
>> +            {"disable", no_argument, 0, OPTION_DISABLE},
>> +            {"disabled", no_argument, 0, OPTION_DISABLE},
>=20
> So if --disable and --disabled are exactly the same, I really don=E2=80=
=99t know
> why --disabled even exists.

Logically, '--add --disabled' matches the name of the QMP command with=20
its optional 'disabled' parameter, while --disable matches the name of=20
the QMP command.  We don't have to have the alias; and in fact, if you=20
agree that supporting '--add --disabled' is too much sugar (since we=20
don't care about atomicity the way QMP did), then life gets simpler to=20
drop --disabled altogether.

>> +    if (add && disable) {
>> +        disable =3D false;
>> +        add_disabled =3D true;
>> +    }
>> +    if (add + remove + clear + enable + disable + !!merge !=3D 1) {
>> +        error_report("Need exactly one mode of --add, --remove, --clear=
, "
>> +                     "--enable, --disable, or --merge");
>=20
> Aha.  So you can actually only do a single operation.
>=20
> That means the doc shouldn=E2=80=99t use {}, in my opinion, because that =
to me
> means repetition (thanks to EBNF).  It definitely served to confuse me
> greatly until this point.

In command line syntax, I'm most used to seeing repetition as '...',=20
optional as [], and mutually-exclusive choice as {|}.  Yes, that's=20
different than EBNF.

>=20
> I also don=E2=80=99t see why we would disallow multiple operations in one=
 go.
> The --add --merge combination seems useful to me, and I don=E2=80=99t see=
 a
> problem in implementing it.
>=20
> I don=E2=80=99t know why we don=E2=80=99t just create a list of operation=
s to execute,
> based on the order given in the argument list, and then execute them in
> order.  That would even allow multiple --merge operations.

If I understand, you're asking why we can't do:

qemu-img bitmap foo.qcow2 --add b1 --merge sb b1

in one operation.

That changes the syntax entirely, compared to what I implemented.  You'd=20
have to have an argument to every option, AND figure out how to specify=20
TWO arguments to the --merge option.  Might be doable, but seems hairy.

>=20
> If we don=E2=80=99t want that (because we don=E2=80=99t want argument ord=
er to matter),
> we could still allow all operations to be done at least once and always
> execute them in the same order, e.g.:
> (1) add
> (2) clear
> (3) merge
> (4) disable
> (5) enable
> (6) remove

I still find it simpler to do exactly one operation per invocation.

>=20
>> +        goto out;
>> +    }
>> +    if (granularity && !add) {
>> +        error_report("granularity only supported with --add");
>> +        goto out;
>> +    }
>> +    if (src_fmt && !src_filename) {
>> +        error_report("-F only supported with -b");
>> +        goto out;
>> +    }
>> +    if (src_filename && !merge) {
>> +        error_report("alternate source file only supported with --merge=
");
>=20
> =E2=80=9Calternate=E2=80=9D sounds strange.  Why not be more precise and =
call it a
> =E2=80=9CMerge bitmap source file=E2=80=9D or =E2=80=9CFile to source mer=
ge bitmap from=E2=80=9D?

"Merge bitmap source file" sounds fine.

>> +
>> +    if (err) {
>> +        error_reportf_err(err, "Bitmap %s operation failed", bitmap);
>=20
> Wouldn=E2=80=99t =E2=80=9COperation on bitmap %s failed=E2=80=9D work bet=
ter?

Yes.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


