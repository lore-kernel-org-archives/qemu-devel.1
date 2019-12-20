Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE2CC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE32C2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJeCKAFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE32C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHix-0002Bq-3j
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iiHi3-0001YH-GX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iiHi1-00054r-OV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:48:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iiHi1-00051G-Ho
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576846124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3j9S/R4xlo1pAIPMNLDQkbFq6J0Nzb84NIwbZsBLi0=;
 b=OJeCKAFLGIHrU+TWtY5sXfAjr8vW9qbIL32YJe9K1mcQ3TiyIL/tSRg3TfB0iCPLmbOwRH
 A/vHcaTbqM6r4k6aNLOwW6L+Stg/hxLXPgsCRyuT6RFfjD5GMjHRzs3XiRxdfX3NSivXTh
 ivsmjTj9M/7Z2Zs158Cd0CcZePcaDyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-yYbjpSqFPreycVdEcHo9uQ-1; Fri, 20 Dec 2019 07:48:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78E361005510;
 Fri, 20 Dec 2019 12:48:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21D3D1001DC0;
 Fri, 20 Dec 2019 12:48:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8687F11386A7; Fri, 20 Dec 2019 13:48:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 02/18] fuse: Allow exporting BDSs via FUSE
References: <20191219143818.1646168-1-mreitz@redhat.com>
 <20191219143818.1646168-3-mreitz@redhat.com>
 <20191220102656.GD4019@dhcp-200-226.str.redhat.com>
 <1812e968-1197-523e-7039-caf29e3bbc4b@redhat.com>
 <20191220112402.GE4019@dhcp-200-226.str.redhat.com>
Date: Fri, 20 Dec 2019 13:48:38 +0100
In-Reply-To: <20191220112402.GE4019@dhcp-200-226.str.redhat.com> (Kevin Wolf's
 message of "Fri, 20 Dec 2019 12:24:02 +0100")
Message-ID: <87pngjgo2h.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yYbjpSqFPreycVdEcHo9uQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 20.12.2019 um 11:48 hat Max Reitz geschrieben:
>> On 20.12.19 11:26, Kevin Wolf wrote:
>> > Am 19.12.2019 um 15:38 hat Max Reitz geschrieben:
>> >> fuse-export-add allows mounting block graph nodes via FUSE on some
>> >> existing regular file.  That file should then appears like a raw disk
>> >> image, and accesses to it result in accesses to the exported BDS.
>> >>
>> >> Right now, we only set up the mount point and tear all mount points d=
own
>> >> in bdrv_close_all().  We do not implement any access functions, so
>> >> accessing the mount point only results in errors.  This will be
>> >> addressed by a followup patch.
>> >>
>> >> The set of exported nodes is kept in a hash table so we can later add=
 a
>> >> fuse-export-remove that allows unmounting.
>> >>
>> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> >=20
>> >> diff --git a/qapi/block.json b/qapi/block.json
>> >> index 145c268bb6..03f8d1b537 100644
>> >> --- a/qapi/block.json
>> >> +++ b/qapi/block.json
>> >> @@ -317,6 +317,29 @@
>> >>  ##
>> >>  { 'command': 'nbd-server-stop' }
>> >> =20
>> >> +##
>> >> +# @fuse-export-add:
>> >> +#
>> >> +# Exports a block graph node on some (file) mountpoint as a raw imag=
e.
>> >> +#
>> >> +# @node-name: Node to be exported
>> >> +#
>> >> +# @mountpoint: Path on which to export the block device via FUSE.
>> >> +#              This must point to an existing regular file.
>> >> +#
>> >> +# @writable: Whether clients should be able to write to the block
>> >> +#            device via the FUSE export. (default: false)
>> >> +#
>> >> +# Since: 5.0
>> >> +##
>> >> +{ 'command': 'fuse-export-add',
>> >> +  'data': {
>> >> +      'node-name': 'str',
>> >> +      'mountpoint': 'str',
>> >> +      '*writable': 'bool'
>> >> +  },
>> >> +  'if': 'defined(CONFIG_FUSE)' }
>> >=20
>> > Can this use a BlockExport union from the start like I'm introducing i=
n
>> > the storage daemon series, together with a generic block-export-add?
>>=20
>> Hm, you mean still adding a FuseExport structure that would be part of
>> BlockExport and then dropping fuse-export-add in favor of a
>> block-export-add that we want anyway?
>
> Yes.
>
>> > It also looks like node-name and writable should be part of the common
>> > base of BlockExport.
>>=20
>> node-name definitely, I=E2=80=99m not so sure about writable.  Or, to be=
 more
>> precise, I think that if we want writable to be in the base, we also
>> want growable to be there: Both are primarily options for the
>> BlockBackend that the exports use.
>>=20
>> But both of course also need to be supported by the export
>> implementation.  nbd can make its BB growable all it wants, but that
>> doesn=E2=80=99t make it work.
>
> Right. Pragmatically, I think exports are very like to support writable,
> but probably rather unlikely to support growable. So I do think there
> would be a point for making writable part of the common base, but not
> growable.
>
>> So if we kept writable and growable in the common base, then the schema
>> would give no information about what exports actually support them.
>>=20
>> On one hand, I don=E2=80=99t know whether it=E2=80=99s important to have=
 this
>> information in a static form, or whether it=E2=80=99s sufficient to lear=
n at
>> runtime.
>>=20
>> On the other, I don=E2=80=99t know whether it=E2=80=99s important to hav=
e those fields
>> in the base or not.  Would it make a difference on the wire?
>
> Not for the command itself, so I think we're free to change it later. It
> might make a difference for introspection, though, not sure. Markus?

QAPI schema introspection is designed to hide the difference between
local members and base members.  You can move members to or from a base
type freely without affecting introspection.  Even if that creates or
deletes the base type.

Example: DriveBackup

    { 'struct': 'DriveBackup',
      'base': 'BackupCommon',
      'data': { 'target': 'str',
                '*format': 'str',
                '*mode': 'NewImageMode' } }

where BackupCommon is

    { 'struct': 'BackupCommon',
      'data': { '*job-id': 'str', 'device': 'str',
                'sync': 'MirrorSyncMode', '*speed': 'int',
                '*bitmap': 'str', '*bitmap-mode': 'BitmapSyncMode',
                '*compress': 'bool',
                '*on-source-error': 'BlockdevOnError',
                '*on-target-error': 'BlockdevOnError',
                '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
                '*filter-node-name': 'str' } }

query-qmp-schema describes DriveBackup like this:

    {"name": "30",
     "members": [
         {"name": "job-id", "default": null, "type": "str"},
         {"name": "device", "type": "str"},
         {"name": "sync", "type": "235"},
         {"name": "speed", "default": null, "type": "int"},
         {"name": "bitmap", "default": null, "type": "str"},
         {"name": "bitmap-mode", "default": null, "type": "236"},
         {"name": "compress", "default": null, "type": "bool"},
         {"name": "on-source-error", "default": null, "type": "237"},
         {"name": "on-target-error", "default": null, "type": "237"},
         {"name": "auto-finalize", "default": null, "type": "bool"},
         {"name": "auto-dismiss", "default": null, "type": "bool"},
         {"name": "filter-node-name", "default": null, "type": "str"},
         {"name": "target", "type": "str"},
         {"name": "format", "default": null, "type": "str"},
         {"name": "mode", "default": null, "type": "234"}],
     "meta-type": "object"}

[...]


