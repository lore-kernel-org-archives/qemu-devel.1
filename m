Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7B6C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E148820728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoRDmFww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E148820728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRcxt-0007Ks-1Z
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRcxE-0006sj-9x
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRcxD-00027c-Do
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:35:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24205
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRcxC-00026d-UC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587652550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrSqBKxFDwvB2vvxAxdnOBMTLp6cExFIJPx3WdyHTJQ=;
 b=WoRDmFww6TJd80SD3ELSz/PT6ypGhGyYImsOJTnpXvgAvwTT2AZ0RAalp3XuI15VirKKWn
 FnyssKdIMGTPZKAJcstVRmHAg1On0HVrehMGwLIEmVZoMwQZqHhhxjWjeOgxwPdVfD7Ipw
 XxtTaIjPKkfVpkv/nISIlaYDZ2omQFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-87wQ3HdZOrOk-vvlTnFvyA-1; Thu, 23 Apr 2020 10:35:38 -0400
X-MC-Unique: 87wQ3HdZOrOk-vvlTnFvyA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F16B08014D8;
 Thu, 23 Apr 2020 14:35:36 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4275D5D70A;
 Thu, 23 Apr 2020 14:35:36 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Allow resize of images with internal snapshots
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200422205355.274706-1-eblake@redhat.com>
 <af50e0f6-3d78-ee51-5540-97fb0fc08f9b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cee813a7-1540-aaa3-b8e1-98dbc84e90ff@redhat.com>
Date: Thu, 23 Apr 2020 09:35:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <af50e0f6-3d78-ee51-5540-97fb0fc08f9b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 8:55 AM, Max Reitz wrote:
> On 22.04.20 22:53, Eric Blake wrote:
>> We originally refused to allow resize of images with internal
>> snapshots because the v2 image format did not require the tracking of
>> snapshot size, making it impossible to safely revert to a snapshot
>> with a different size than the current view of the image.  But the
>> snapshot size tracking was rectified in v3, and our recent fixes to
>> qemu-img amend (see 0a85af35) guarantee that we always have a valid
>> snapshot size.  Thus, we no longer need to artificially limit image
>> resizes, but it does become one more thing that would prevent a
>> downgrade back to v2.  And now that we support different-sized
>> snapshots, it's also easy to fix reverting to a snapshot to apply the
>> new size.
>>
>> Upgrade iotest 61 to cover this (we previously had NO coverage of
>> refusal to resize while snapshots exist).  Note that the amend process
>> can fail but still have effects: in particular, since we break things
>> into upgrade, resize, downgrade, if a failure does not happen until a
>> later phase (such as the downgrade attempt), earlier steps are still
>> visible (a truncation and downgrade attempt will fail, but only after
>> truncating data).  But even before this patch, an attempt to upgrade
>> and resize would fail but only after changing the image to v3.  In
>> some sense, partial image changes on failure are inevitible, since we
>> can't avoid a mid-change EIO (if you are trying to amend more than one
>> thing at once, but something fails, I hope you have a backup image).
>>

>> @@ -775,10 +776,22 @@ int qcow2_snapshot_goto(BlockDriverState *bs, cons=
t char *snapshot_id)
>>       }
>>
>>       if (sn->disk_size !=3D bs->total_sectors * BDRV_SECTOR_SIZE) {
>> -        error_report("qcow2: Loading snapshots with different disk "
>> -            "size is not implemented");
>> -        ret =3D -ENOTSUP;
>> -        goto fail;
>> +        BlockBackend *blk =3D blk_new(bdrv_get_aio_context(bs),
>> +                                    BLK_PERM_RESIZE, BLK_PERM_ALL);
>> +        ret =3D blk_insert_bs(blk, bs, &local_err);
>=20
> I wonder whether maybe we should reintroduce blk_new_with_bs().

This code segment is copied from what 'qemu-img amend' does, so adding a=20
helper function would indeed make life a bit easier for more than one=20
spot in the code base.  Separate patch, obviously.


>> +++ b/block/qcow2.c
>> @@ -3988,14 +3988,21 @@ static int coroutine_fn qcow2_co_truncate(BlockD=
riverState *bs, int64_t offset,
>>
>>       qemu_co_mutex_lock(&s->lock);
>>
>> -    /* cannot proceed if image has snapshots */
>> -    if (s->nb_snapshots) {
>> -        error_setg(errp, "Can't resize an image which has snapshots");
>> +    /*
>> +     * Even though we store snapshot size for all images, it was not
>> +     * required until v3, so it is not safe to proceed for v2.
>> +     */
>> +    if (s->nb_snapshots && s->qcow_version < 3) {
>> +        error_setg(errp, "Can't resize a v2 image which has snapshots")=
;
>>           ret =3D -ENOTSUP;
>>           goto fail;
>>       }
>>
>> -    /* cannot proceed if image has bitmaps */
>> +    /*
>> +     * For now, it's easier to not proceed if image has bitmaps, even
>> +     * though we could resize bitmaps, because it is not obvious
>> +     * whether new bits should be set or clear.
>=20
> The previous comment was incorrect as well, but actually
> qcow2_truncate_bitmaps_check() doesn=E2=80=99t return an error when there=
 is any
> bitmap, but only if there are non-active bitmaps, or active bitmaps that
> cannot be modified.  So for non-disabled bitmaps, we generally do
> happily proceed.

The comment change is collateral (only because I noticed it in the=20
diff); but I could indeed reword it slightly more accurately as:

Check if bitmaps prevent a resize.  Although bitmaps can be resized,=20
there are situations where we don't know whether to set or clear new=20
bits, so for now it's easiest to just prevent resize in those cases.

And since it is a collateral change, it may even be worth splitting into=20
a separate patch.

>> +++ b/tests/qemu-iotests/061
>> @@ -111,6 +111,29 @@ $PYTHON qcow2.py "$TEST_IMG" dump-header
>>   $QEMU_IO -c "read -P 0x2a 42M 64k" "$TEST_IMG" | _filter_qemu_io
>>   _check_test_img
>>
>> +echo
>> +echo "=3D=3D=3D Testing resize with snapshots =3D=3D=3D"
>> +echo
>> +_make_test_img -o "compat=3D0.10" 32M
>> +$QEMU_IO -c "write -P 0x2a 24M 64k" "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IMG snapshot -c foo "$TEST_IMG"
>> +$QEMU_IMG resize "$TEST_IMG" 64M                         # fails
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header
>=20
> What am I looking for in the header dump?

I was looking primarily for version (2 vs. 3), size (did it change), and=20
number of snapshots.  You're right that grepping for what changes will=20
make this easier to maintain.


> Also, I personally prefer self-testing tests, because I don=E2=80=99t tru=
st
> myself when I have to interpret the reference output on my own...  As
> such, I think it would make sense to not just put those =E2=80=9C# fails=
=E2=80=9D
> comments here, but an explicit test on $? instead.  (E.g. by
> =E2=80=9C|| echo ERROR=E2=80=9D, although I can see that would be weird i=
n the
> expected-failure case as =E2=80=9C&& echo ERROR=E2=80=9D.)

Good idea.

>=20
>> +$QEMU_IMG snapshot -c bar "$TEST_IMG"
>> +$QEMU_IMG resize --shrink "$TEST_IMG" 64M                # succeeds
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header
>> +$QEMU_IMG amend -o "compat=3D0.10,size=3D32M" "$TEST_IMG"    # fails, i=
mage left v3
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header
>=20
> Again, a grep for the image size would help focus the reference output.
>=20
> (In addition, _img_info would give us snapshot information.  Might be
> interesting.  So maybe the best thing would be to grep the image
> version, image size, and snapshot list from the image info every time.)

Yep, that's the same list I was noticing when writing the patch.

>=20
> Speaking of the image size.  Is it intentional that the size is changed
> to 32 MB?  Should amend work more like a transaction, in that we should
> at least do a loose check on whether the options can be changed before
> we touch the image?

Yes, the commit message tried to call it out.  It's a pre-existing=20
problem - during amend, we DO make changes to the disk in one step, with=20
no way to roll back those changes, even if a later step fails.

Pre-patch, if you request an upgrade to v3 as well as a resize, but=20
resize fails, you still end up with the image being changed to v3.=20
That's no different from post-patch where if you request a resize and a=20
downgrade to v2, the resize happens but not the downgrade.  On the=20
bright side, our current failure scenarios at least leave the resulting=20
image viable, even if it is not the same as it was pre-attempt.

>=20
> Also, there=E2=80=99s a problem of ordering here.  The command as you=E2=
=80=99ve written
> doesn=E2=80=99t have this specific problem, but imagine the size was stil=
l 128
> MB before (just like the snapshot).  Then what the command does depends
> on the order in which the operations are executed: If we change the
> version first, the size cannot be changed because of the internal
> snapshot.  If we change the size first, the version can no longer be
> changed because the internal snapshot has a different size than the image=
.

Yes, it was a pain for me while writing the tests.  At one point I even=20
considered swapping things to do the resize after the downgrade, but=20
that introduces a different problem: the downgrade depends on knowing=20
the post-transaction size (because downgrading is safe only when all=20
internal snapshots match the post-resize length), but we aren't passing=20
the desired size through to the upgrade and downgrade functions.  Worse,=20
if we swap the downgrade first, and it succeeds but then resize fails,=20
the image is no longer viable; at least with the current ordering, even=20
though user data has been truncated, it remains v3 so the size=20
differences in snapshots don't break the image (and the user DID request=20
an image resize, so it's not like we are discarding data accidentally).

If we want to avoid truncating an image at all costs on any potential=20
failure path, we have to add a lot more plumbing (not to say it's a bad=20
thing, just that it's more work).  And no matter how much plumbing we=20
add, or transaction-like rollback capabilities we add, there's still the=20
risk that we will hit a late EIO error leaving the image in a=20
half-changed state, even if none of our sanity checks failed.  Or put=20
another way, without some sort of journaling, the best we can do is=20
defer all writes until we know the full set of changes, which limits the=20
likelihood of a half-baked change to a write failure.  But since we can=20
only reduce, and not eliminate, the possibility of a half-baked change,=20
the question then becomes whether it is worth the engineering effort of=20
additional complexity for even more corner cases and less risk, or just=20
leave things as they are (if qemu-img amend fails, we make no guarantees=20
about the state of your image).

>=20
>=20
> (Hypothetical problems that turn out not to be any in practice:
>=20
> Or, maybe more interesting: What if we try to amend to
> compat=3D0.10,size=3D128M here?
>=20
> If the size is changed first, the command will succeed, because then the
> snapshot size matches the image size again.  If qemu-img attempts to
> change the version first, the whole command will fail.
>=20
> As I noted above, the size is indeed changed before the version (hence
> us getting a 32 MB v3 image here), so the compat=3D0.10,size=3D128M amend
> would indeed succeed.  But that=E2=80=99s luck.
>=20
> OTOH, that means that if you have a v2 image with a snapshot and want to
> make it a v3 image and resize it at the same time, that would fail by
> the same logic, because the size cannot be changed for v2 images.  So
> for that case it=E2=80=99d be bad luck.
>=20
> But we always upgrade an image first in the amend process and downgrade
> it last, to address specifically such cases: Allow adding new features
> along with the upgrade, and strip unsupported features right before the
> downgrade.  So that=E2=80=99s all good.  But I think it still shows that =
the
> dependencies are getting a bit hairy.)

I'm not sure the work in making amend more transaction-like is worth it=20
- yes, we can add more validation code up front before making the first=20
write change, but as some of the later changes depend on information=20
that would be changed earlier, that becomes a lot more state we have to=20
collect during our initial probes (my example being that the downgrade=20
attempt depends on knowing the final image size, and that's a lot easier=20
when the image has already been resized rather than having to pass the=20
new size through).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


