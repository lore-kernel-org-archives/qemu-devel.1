Received: from eggs.gnu.org ([2001:4830:134:3::10]:47142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5xCP-0008PH-Vv
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:32:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5xCM-0007BG-Rb
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:32:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d5xCM-0007At-IC
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:32:18 -0400
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1493735386-39622-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<4ccaf863-4c73-e168-3c09-c916a6aaa75e@redhat.com>
	<25938992-bdea-4f0c-0b9c-0467b8684b98@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8b789ab-97d9-6bf6-e7bd-49b9260827ee@redhat.com>
Date: Wed, 3 May 2017 11:32:13 -0500
MIME-Version: 1.0
In-Reply-To: <25938992-bdea-4f0c-0b9c-0467b8684b98@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CF5jKqwkiW8dgCKglno4SlecT5T5T3Nv9"
Subject: Re: [Qemu-devel] [PATCH v3 2/4] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CF5jKqwkiW8dgCKglno4SlecT5T5T3Nv9
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>,
 jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
Message-ID: <c8b789ab-97d9-6bf6-e7bd-49b9260827ee@redhat.com>
Subject: Re: [PATCH v3 2/4] fsdev: QMP interface for throttling
References: <1493735386-39622-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1493735386-39622-3-git-send-email-pradeep.jagadeesh@huawei.com>
 <4ccaf863-4c73-e168-3c09-c916a6aaa75e@redhat.com>
 <25938992-bdea-4f0c-0b9c-0467b8684b98@huawei.com>
In-Reply-To: <25938992-bdea-4f0c-0b9c-0467b8684b98@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/03/2017 10:40 AM, Pradeep Jagadeesh wrote:
> On 5/3/2017 12:13 AM, Eric Blake wrote:
>> On 05/02/2017 09:29 AM, Pradeep Jagadeesh wrote:
>>> This patchset enables qmp interfaces for the fsdev
>>> devices. This provides two interfaces one
>>> for querying info of all the fsdev devices. The second one
>>> to set the IO limits for the required fsdev device.
>>>
>>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>>> ---
>>

>>> +void fsdev_set_io_throttle(IOThrottle *arg, FsThrottle *fst, Error
>>> **errp)
>>> +{
>>> +    ThrottleConfig cfg;
>>> +
>>> +    throttle_config_init(&cfg);
>>> +    cfg.buckets[THROTTLE_BPS_TOTAL].avg =3D arg->bps;
>>> +    cfg.buckets[THROTTLE_BPS_READ].avg  =3D arg->bps_rd;
>>> +    cfg.buckets[THROTTLE_BPS_WRITE].avg =3D arg->bps_wr;
>>> +
>>> +    cfg.buckets[THROTTLE_OPS_TOTAL].avg =3D arg->iops;
>>> +    cfg.buckets[THROTTLE_OPS_READ].avg  =3D arg->iops_rd;
>>> +    cfg.buckets[THROTTLE_OPS_WRITE].avg =3D arg->iops_wr;
>>> +
>>> +    if (arg->has_bps_max) {
>>> +        cfg.buckets[THROTTLE_BPS_TOTAL].max =3D arg->bps_max;
>>> +    }
>>
>> Should the bulk of this be replaced by a call to a common IOThrottle
>> helper function, rather than open-coded duplication?
> If we can reduce the duplicate code with a helper function its a good
> idea. But I can not think of any ways of doing it. Any suggestions?

In fact, you did exactly that in patch 3/4, which I argue should be
rebased to occur in front of this patch to minimize the churn (in other
words, when you add fsdev_set_io_throttle(), it should directly call the
qmp_set_io_throttle() helper).


>>> +void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
>>> +{
>>> +    Error *err =3D NULL;
>>> +    IOThrottle throttle =3D {
>>> +        .has_id =3D true,
>>> +        .id =3D (char *) qdict_get_str(qdict, "id"),
>>> +        .bps =3D qdict_get_int(qdict, "bps"),
>>> +        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
>>> +        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
>>> +        .iops =3D qdict_get_int(qdict, "iops"),
>>> +        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
>>> +        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
>>
>> Again, don't you need to be setting .has_bps=3Dtrue and so on?
> Same as above. I have not set any max burst values here, because I
> wanted to keep it in line with the block device.
> May be there is a room to enable these max values in both in future.

I don't think you were getting the point of my question. Since 'bps' is
an optional member of struct IOThrottle, you have to set 'has_bps' at
the same time to make it obvious that 'bps' should affect things.

I understand that you aren't setting 'bps_max', nor it's counterpart
'has_bps_max', and that's not what I was asking about.


>>> +++ b/qapi/iothrottle.json
>>> @@ -3,6 +3,7 @@
>>>  ##
>>>  # =3D=3D QAPI IOThrottle definitions
>>>  ##
>>> +##
>>>  # @IOThrottle:
>>
>> This looks like a spurious change
> You mean the below sentence is not required?

No, the above addition of a second ## is not required.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CF5jKqwkiW8dgCKglno4SlecT5T5T3Nv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCgYOAAoJEKeha0olJ0NqLkMH/iQ8s2gECCOVi7qbErcvPgZC
0rcp7d+EUKVlkbftiVmhyTrQV+MftqTgoiXS/t4vn7Xj2tcQlP25WDlK0UNpfX1w
aSSh5Vnj5qmCcryMP+csgdmq96fZLR4IY+bYvsGvP4crnc5fPwyLkRxM7mN84KjV
W5qW8tkpJEr0tQFKSWDhqheVLDQxPMjE9tX1GG3YXko2dL0DCyvsl8ltH2cR+WLu
cuSWs/MoMJGekF92YVhFRxssuZkBp3/3/Hl4VCmwBqNokSZlHD9ir6N+yPRm9NO5
X8IYZN25yYTwjP9Viv1OomjypRPqK1AQp8Oy4UHlO2z/Tr/FDhw2H8lABblp/8Q=
=5Lm0
-----END PGP SIGNATURE-----

--CF5jKqwkiW8dgCKglno4SlecT5T5T3Nv9--
