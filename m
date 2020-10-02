Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E73C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 19:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E99206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 19:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/hCrMcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E99206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOR1i-0001zs-0q
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 15:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kOR0a-0001Fc-PZ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 15:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kOR0U-0001VJ-Em
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 15:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601667976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oWZuHso1fqMMCwrPJpEjpfH+ITw/PAYZ+gdPCK4/Mf4=;
 b=J/hCrMcWyQhOAi35WD5uLnL83mCg0llwGprxhMhUlGsmGQzCrQb8Itb/HaShIh1+yXvZJ0
 MEFgfEjvNTHxUVDUT/l2X53LXlvOH9zfHxk6fF2AOmXviTdQ82xffYBPXdFr11h4lGSoQw
 jy2SprDyZjyVFzvwvYKLCzWnujk8y/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-nkVSNBxFNd6-8c-29Iledw-1; Fri, 02 Oct 2020 15:46:11 -0400
X-MC-Unique: nkVSNBxFNd6-8c-29Iledw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72DEA802B47;
 Fri,  2 Oct 2020 19:46:10 +0000 (UTC)
Received: from [10.3.112.222] (ovpn-112-222.phx2.redhat.com [10.3.112.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ECD078809;
 Fri,  2 Oct 2020 19:46:08 +0000 (UTC)
Subject: Re: [PATCH v5 10/10] migration: introduce snapshot-{save, load,
 delete} QMP commands
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201002162747.3123597-1-berrange@redhat.com>
 <20201002162747.3123597-11-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Autocrypt: addr=eblake@redhat.com; keydata=
 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
Organization: Red Hat, Inc.
Message-ID: <ef01ef63-7b95-88c2-5d31-103d29f9f64f@redhat.com>
Date: Fri, 2 Oct 2020 14:46:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201002162747.3123597-11-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d42DOcowMwkY3dMdTo8GGMVjRoLvRl4nz"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d42DOcowMwkY3dMdTo8GGMVjRoLvRl4nz
Content-Type: multipart/mixed; boundary="g5gImbC8Qv9TUVNiWNC8jHT2qhHMozp0U";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>,
 qemu-block@nongnu.org
Message-ID: <ef01ef63-7b95-88c2-5d31-103d29f9f64f@redhat.com>
Subject: Re: [PATCH v5 10/10] migration: introduce snapshot-{save,load,delete}
 QMP commands
References: <20201002162747.3123597-1-berrange@redhat.com>
 <20201002162747.3123597-11-berrange@redhat.com>
In-Reply-To: <20201002162747.3123597-11-berrange@redhat.com>

--g5gImbC8Qv9TUVNiWNC8jHT2qhHMozp0U
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/2/20 11:27 AM, Daniel P. Berrang=C3=A9 wrote:
> savevm, loadvm and delvm are some of the few HMP commands that have never
> been converted to use QMP. The reasons for the lack of conversion are
> that they blocked execution of the event thread, and the semantics
> around choice of disks were ill-defined.
>=20
> Despite this downside, however, libvirt and applications using libvirt
> have used these commands for as long as QMP has existed, via the
> "human-monitor-command" passthrough command. IOW, while it is clearly
> desirable to be able to fix the problems, they are not a blocker to
> all real world usage.
>=20
> Meanwhile there is a need for other features which involve adding new
> parameters to the commands. This is possible with HMP passthrough, but
> it provides no reliable way for apps to introspect features, so using
> QAPI modelling is highly desirable.
>=20
> This patch thus introduces new snapshot-{load,save,delete} commands to
> QMP that are intended to replace the old HMP counterparts. The new
> commands are given different names, because they will be using the new
> QEMU job framework and thus will have diverging behaviour from the HMP
> originals. It would thus be misleading to keep the same name.
>=20
> While this design uses the generic job framework, the current impl is
> still blocking. The intention that the blocking problem is fixed later.
> None the less applications using these new commands should assume that
> they are asynchronous and thus wait for the job status change event to
> indicate completion.
>=20
> In addition to using the job framework, the new commands require the
> caller to be explicit about all the block device nodes used in the
> snapshot operations, with no built-in default heuristics in use.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

> +++ b/qapi/job.json
> @@ -22,10 +22,17 @@
>  #
>  # @amend: image options amend job type, see "x-blockdev-amend" (since 5.=
1)
>  #
> +# @snapshot-load: snapshot load job type, see "snapshot-load" (since 5.2=
)
> +#
> +# @snapshot-save: snapshot save job type, see "snapshot-save" (since 5.2=
)
> +#
> +# @snapshot-delete: snapshot delete job type, see "snapshot-delete" (sin=
ce 5.2)
> +#
>  # Since: 1.7
>  ##
>  { 'enum': 'JobType',
> -  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
> +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend',
> +           'snapshot-load', 'snapshot-save', 'snapshot-delete'] }
> =20
>  ##
>  # @JobStatus:
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7f5e6fd681..d2bd551ad9 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1787,3 +1787,123 @@
>  # Since: 5.2
>  ##
>  { 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
> +
> +##
> +# @snapshot-save:
> +#
> +# Save a VM snapshot
> +#
> +# @job-id: identifier for the newly created job
> +# @tag: name of the snapshot to create
> +# @devices: list of block device node names to save a snapshot to
> +# @vmstate: block device node name to save vmstate to

Here, you document vmstate last,...

> +#
> +# Applications should not assume that the snapshot save is complete
> +# when this command returns. The job commands / events must be used
> +# to determine completion and to fetch details of any errors that arise.
> +#
> +# Note that the VM CPUs will be paused during the time it takes to
> +# save the snapshot

"will be", or "may be"?  As you stated above, we may be able to lift the
synchronous limitations down the road, while still maintaining the
present interface of using this command to start the job and waiting on
the job id until it is finished, at which point the CPUs might not need
to be paused as much.

> +#
> +# It is strongly recommended that @devices contain all writable
> +# block device nodes if a consistent snapshot is required.
> +#
> +# If @tag already exists, an error will be reported
> +#
> +# Returns: nothing
> +#
> +# Example:
> +#
> +# -> { "execute": "snapshot-save",
> +#      "data": {
> +#         "job-id": "snapsave0",
> +#         "tag": "my-snap",
> +#         "vmstate": "disk0",
> +#         "devices": ["disk0", "disk1"]

...here vmstate occurs before devices.  I don't know if our doc
generator cares about inconsistent ordering.

> +#      }
> +#    }
> +# <- { "return": { } }
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'snapshot-save',
> +  'data': { 'job-id': 'str',
> +            'tag': 'str',
> +            'vmstate': 'str',
> +            'devices': ['str'] } }
> +
> +##
> +# @snapshot-load:
> +#
> +# Load a VM snapshot
> +#
> +# @job-id: identifier for the newly created job
> +# @tag: name of the snapshot to load.
> +# @devices: list of block device node names to load a snapshot from
> +# @vmstate: block device node name to load vmstate from
> +#
> +# Applications should not assume that the snapshot save is complete
> +# when this command returns. The job commands / events must be used
> +# to determine completion and to fetch details of any errors that arise.

s/save/load/

> +#
> +# Note that the VM CPUs will be paused during the time it takes to
> +# save the snapshot

s/save/load/

But while pausing CPUs during save is annoying, pausing CPUs during
restore makes sense (after all, executing on stale data that will still
be updated during the restore is just wasted execution).


> +#
> +# It is strongly recommended that @devices contain all writable
> +# block device nodes that can have changed since the original
> +# @snapshot-save command execution.
> +#
> +# Returns: nothing
> +#
> +# Example:
> +#
> +# -> { "execute": "snapshot-load",
> +#      "data": {
> +#         "job-id": "snapload0",
> +#         "tag": "my-snap",
> +#         "vmstate": "disk0",
> +#         "devices": ["disk0", "disk1"]
> +#      }
> +#    }
> +# <- { "return": { } }
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'snapshot-load',
> +  'data': { 'job-id': 'str',
> +            'tag': 'str',
> +            'vmstate': 'str',
> +            'devices': ['str'] } }
> +
> +##
> +# @snapshot-delete:
> +#
> +# Delete a VM snapshot
> +#
> +# @job-id: identifier for the newly created job
> +# @tag: name of the snapshot to delete.
> +# @devices: list of block device node names to delete a snapshot from
> +#
> +# Applications should not assume that the snapshot save is complete
> +# when this command returns. The job commands / events must be used
> +# to determine completion and to fetch details of any errors that arise.

Do we have a query- command handy to easily learn which snapshot names
are even available to attempt deletion on?  If not, that's worth a
separate patch.

> +#
> +# Returns: nothing
> +#
> +# Example:
> +#
> +# -> { "execute": "snapshot-delete",
> +#      "data": {
> +#         "job-id": "snapdelete0",
> +#         "tag": "my-snap",
> +#         "devices": ["disk0", "disk1"]
> +#      }
> +#    }
> +# <- { "return": { } }
> +#
> +# Since: 5.2
> +##

> +++ b/tests/qemu-iotests/group
> @@ -291,6 +291,7 @@
>  277 rw quick
>  279 rw backing quick
>  280 rw migration quick
> +310 rw quick
>  281 rw quick
>  282 rw img quick
>  283 auto quick

What's wrong with sorted order? I get the renumbering to appease a merge
conflict, but it also requires rearrangement ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--g5gImbC8Qv9TUVNiWNC8jHT2qhHMozp0U--

--d42DOcowMwkY3dMdTo8GGMVjRoLvRl4nz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl93g38ACgkQp6FrSiUn
Q2rYpQf/Yidj8EYptD5CqkxDCMJOflCDYuwDEiZPRherPCF4vUdi07/vZuBU9Rg3
CiASfvh2DStdyvKar89Abnsma6zeHX3BqkVa5gEEWxh25XJ0fWQGI4qmCXrBdV81
3qZ0cgOGYLWZjFI2hqGnBlybxF33fzc+4ByIgjcQmrrr55xUGq0BQHs+g8ncR6Wg
X1vynGAfNVN2UfAfsFM3bGjHe96TKrBCtzSQzV8ms/jIQplJJg6Mu2ndoIPGz/wY
qYSNCc2pP6GlTwrL/7wViKVgpG6Wj3sam938FTFhAp7JuetbO7gZsycxY7DVKj7X
wKVsxaSdCJ4ZizPqxgL6X/+je3Valg==
=s2su
-----END PGP SIGNATURE-----

--d42DOcowMwkY3dMdTo8GGMVjRoLvRl4nz--


