Received: from eggs.gnu.org ([2001:4830:134:3::10]:51672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dev@acronis.com>) id 1eRbwM-0000Wz-4U
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dev@acronis.com>) id 1eRbwH-0005ff-Ke
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:49:34 -0500
From: Kirill Korotaev <dev@acronis.com>
Date: Wed, 20 Dec 2017 10:29:27 +0000
Message-ID: <7C731D1E-BAC3-498A-AA93-1713C9A7B8B1@acronis.com>
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<20171213041248.GB31040@lemon>
	<af98ffe7-71fb-0493-c4da-4b77a4c453f5@virtuozzo.com>
	<696c198b-e3d8-fab6-0128-de9ed34e4cff@redhat.com>
	<d5df7e51-fe6b-da89-9bf1-9b03c1afdd67@virtuozzo.com>
In-Reply-To: <d5df7e51-fe6b-da89-9bf1-9b03c1afdd67@virtuozzo.com>
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_7F62D689-EC4D-401E-83CB-4642886E7BE4";
	protocol="application/pkcs7-signature"; micalg=sha1
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, Nestratov Maxim <mnestratov@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "nshirokovskiy@virtuozzo.com" <nshirokovskiy@virtuozzo.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Vadim Smolev <Vadim.Smolev@acronis.com>

--Apple-Mail=_7F62D689-EC4D-401E-83CB-4642886E7BE4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Lets me add a couple of words from backup vendor side:

1. pull backup is very important to have, it enables additional =
important functionality:
1. User can select separate volumes (rather then disks) to backup
2. User can select specific files/folders to backup (!)
3. Backup software can automatically skip copying useless data like swap =
file/partition.=20
All 3 require disk/filesystem analysis, i.e. random disk access on =
demand (rather then "push all=E2=80=9D approach).
2. It is important to have multiple CBT bitmaps and be able to detect =
modifications between different point in times because one might have at =
least 2 applications interested in CBT:
a. backup
b. replication

Thanks,
Kirill


> On 20 Dec 2017, at 11:20, Vladimir Sementsov-Ogievskiy =
<vsementsov@virtuozzo.com> wrote:
>=20
> 20.12.2017 04:06, John Snow wrote:
>>=20
>> On 12/19/2017 11:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 13.12.2017 07:12, Fam Zheng wrote:
>>>> On Mon, 11/13 19:20, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Hi all.
>>>>>=20
>>>>> There are three qmp commands, needed to implement external backup =
API.
>>>>>=20
>>>>> Using these three commands, client may do all needed bitmap
>>>>> management by
>>>>> hand:
>>>>>=20
>>>>> on backup start we need to do a transaction:
>>>>>   {disable old bitmap, create new bitmap}
>>>>>=20
>>>>> on backup success:
>>>>>   drop old bitmap
>>>>>=20
>>>>> on backup fail:
>>>>>   enable old bitmap
>>>>>   merge new bitmap to old bitmap
>>>>>   drop new bitmap
>>>>>=20
>>>>> Question: it may be better to make one command instead of two:
>>>>> block-dirty-bitmap-set-enabled(bool enabled)
>>>>>=20
>>>>> Vladimir Sementsov-Ogievskiy (4):
>>>>>    block/dirty-bitmap: add lock to =
bdrv_enable/disable_dirty_bitmap
>>>>>    qapi: add block-dirty-bitmap-enable/disable
>>>>>    qmp: transaction support for block-dirty-bitmap-enable/disable
>>>>>    qapi: add block-dirty-bitmap-merge
>>>>>=20
>>>>>   qapi/block-core.json         |  80 +++++++++++++++++++++++
>>>>>   qapi/transaction.json        |   4 ++
>>>>>   include/block/dirty-bitmap.h |   2 +
>>>>>   block/dirty-bitmap.c         |  21 ++++++
>>>>>   blockdev.c                   | 151
>>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>>   5 files changed, 258 insertions(+)
>>>>>=20
>>>> I think tests are required to merge new features/commands.  Can we
>>>> include tests
>>>> on these new code please?  We should cover error handling, and also
>>>> write tests
>>>> that demonstrate the intended real world use cases.
>>>>=20
>>>> Also should we add new sections to docs/interop/bitmaps.rst?
>>>>=20
>>>> Meta: John started a long discussion about the API design but I =
think
>>>> after all
>>>> it turns out exposing dirty bitmap objects and the primitives is a
>>>> reasonable
>>>> approach to implement incremental backup functionalities. The =
comment
>>>> I have is
>>>> that we should ensure we have also reviewed it from a higher level
>>>> (e.g. all the
>>>> potential user requirements) to make sure this low level API is =
both
>>>> sound and
>>>> flexible. We shouldn't introduce a minimal set of low level =
commands
>>>> just to
>>>> support one particular use case, but look a bit further and broader
>>>> and come up
>>>> with a more complete design? Writing docs and tests might force us =
to
>>>> think in
>>>> this direction, which I think is a good thing to have for this =
series,
>>>> too.
>>>>=20
>>>> Fam
>>> Nikolay, please describe what do you plan in libvirt over qmp bitmap =
API.
>>>=20
>>> Kirill, what do you think about this all?
>>>=20
>>> (brief history:
>>> we are considering 3 new qmp commands for bitmap management, needed =
for
>>> external incremental backup support
>>>  - enable (bitmap will track disk changes)
>>>  - disable (bitmap will stop tracking changes)
>>>  - merge (merge bitmap A to bitmap B)
>>> )
>>>=20
>> Yeah, it would be helpful to know what the full workflow for the API
>> will be ... before I get ahead of myself again (sorry) ...
>>=20
>> but I'd like to see a quick writeup of your vision for the pull-mode
>> backups (which I assume this is for, right?) from start-to-finish, =
like
>> a mockup of annotated QMP output or something.
>>=20
>> Nothing fancy, just something that lets me orient where we're headed,
>> since you're doing most of the work and I just want to get out of =
your
>> way, but having a roadmap helps me do that.
>>=20
>> --js
>=20
> external backup:
>=20
> 0. we have active_disk and attached to it dirty bitmap bitmap0
> 1. qmp blockdev-add tmp_disk (backing=3Dactive_disk)
> 2. guest fsfreeze
> 3. qmp transaction:
>         - block-dirty-bitmap-add node=3Dactive_disk name=3Dbitmap1
>         - block-dirty-bitmap-disable node=3Dactive_disk name=3Dbitmap0
>         - blockdev-backup drive=3Dactive_disk target=3Dtmp_disk =
sync=3Dnone
> 4. guest fsthaw
> 5. (? not designed yet) qmp blockdev-add filter_node - special filter =
node over tmp_disk for synchronization of nbd-reads and =
backup(sync=3Dnone) cow requests (like it is done in block/replication)
> 6. qmp nbd-server-start
> 7. qmp nbd-server-add filter_node (there should be possibility of =
exporting bitmap of child node =
filter_node->tmp_disk->active_disk->bitmap0)
>=20
> then, external tool can connect to nbd server and get exported bitmap =
and read data (including bitmap0) accordingly to nbd specification.
> (also, external tool may get a merge of several bitmaps, if we already =
have a sequence of them)
> then, after backup finish, what can be done:
>=20
> 1. qmp block-job-cancel device=3Dactive_disk (stop our =
backup(sync=3Dnone))
> 2. qmp nbd-server-stop (or qmp nbd-server-remove filter_node)
> 3. qmp blockdev-remove filter_node
> 4. qmp blockdev-remove tmp_disk
>=20
> on successful backup, you can drop old bitmap if you want (or do not =
drop it, if you need to keep sequence of disabled bitmaps):
> 1. block-dirty-bitmap-remove node=3Dactive_disk name=3Dbitmap0
>=20
> on failed backup, you can merge bitmaps, to make it look like nothing =
happened:
> 1. qmp transaction:
>        - block-dirty-bitmap-merge node=3Dactive_disk =
name-source=3Dbitmap1 name-target=3Dbitmap0
>        - block-dirty-bitmap-remove node=3Dactive_disk name=3Dbitmap1
>        - block-dirty-bitmap-enable node=3Dactive_disk name=3Dbitmap0
>=20
> --=20
> Best regards,
> Vladimir
>=20


--Apple-Mail=_7F62D689-EC4D-401E-83CB-4642886E7BE4
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKLDCCBQcw
ggPvoAMCAQICEwbF+4ojCckhUTdejom8evn7KgswDQYJKoZIhvcNAQELBQAwgaQxCzAJBgNVBAYT
AlVTMREwDwYDVQQIEwhJbGxpbm9pczEQMA4GA1UEBxMHQ2hpY2FnbzEhMB8GA1UEChMYVHJ1c3R3
YXZlIEhvbGRpbmdzLCBJbmMuMSwwKgYDVQQDEyNUcnVzdHdhdmUgUy9NSU1FIFNIQTI1NiBDQSwg
TGV2ZWwgMTEfMB0GCSqGSIb3DQEJARYQY2FAdHJ1c3R3YXZlLmNvbTAeFw0xNzExMTIxMjM3NDBa
Fw0yMDExMTExODM3NDBaMGcxGDAWBgNVBAMMD2RldkBhY3JvbmlzLmNvbTEOMAwGA1UEChMFc21p
bWUxDjAMBgNVBAgTBXNtaW1lMQswCQYDVQQGEwJVUzEeMBwGCSqGSIb3DQEJARYPZGV2QGFjcm9u
aXMuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAz6XQqbUCPh86WgpSOwiD9dZc
l6dzA1iOwGk9KHIwxJuYbxWwtlboMa6SdO6W4IKlkmB4P93hy1ifV+Xzw6OfaMSso9ZSDXBKh2mQ
cjd8fDZdjMrN5x0wUkoRjSOA699p51BXyoearh7fnL88Ez49VbZez13BfedzQ7FkbhhV+kYZ8qu2
R5uD1oAtB1B2S+XEOXWAafeN6M3u8p+I6Mv6jyTBW8WlLEV9cLZYDfZHmn3cfUifNE5LTZ0ghv35
GKNbEhj/jDEtcdWQ2Z5ZEo9eE9OfLqEt2Sml+0WOsaCrkzQoV3Fg7TD2H4dxcp+8meyIxrGRMAH1
ahSLqZjxOzb82wIDAQABo4IBbDCCAWgwDAYDVR0TAQH/BAIwADAOBgNVHQ8BAf8EBAMCBaAwEwYD
VR0lBAwwCgYIKwYBBQUHAwQwHQYDVR0OBBYEFOScklG1DiRAd7En3V/VRxqhEqewMB8GA1UdIwQY
MBaAFAwzo1eq46vWS3AbNp6j7WFQ5q90MEgGA1UdIARBMD8wPQYPKwYBBAGB7RgDAwMFBAMDMCow
KAYIKwYBBQUHAgEWHGh0dHBzOi8vc3NsLnRydXN0d2F2ZS5jb20vQ0EwNgYDVR0fBC8wLTAroCmg
J4YlaHR0cDovL2NybC50cnVzdHdhdmUuY29tL1NNQ0EyX0wxLmNybDBxBggrBgEFBQcBAQRlMGMw
JgYIKwYBBQUHMAGGGmh0dHA6Ly9vY3NwLnRydXN0d2F2ZS5jb20vMDkGCCsGAQUFBzAChi1odHRw
Oi8vc3NsLnRydXN0d2F2ZS5jb20vaXNzdWVycy9TTUNBMl9MMS5jcnQwDQYJKoZIhvcNAQELBQAD
ggEBAEomIzscNZpvJi48w/4H/KhKD7kO/rPTnwIQjOiFxXR7tasi8qAOutugIt4MPP7e1TAl/EJq
XXyJpWZPaMK1bRrwIN07JPoEfyRhtlBc2kWEIjROa9mXVoY+1Z7hAqv559cvBPWh/5Q+U5HbQKLV
ln3spfhIelY7Oi34fNLUy730wJ7hfhFnl5/cOb9rYVgGPUv3SUn0b2sFjKX0PYgqJ6wdMZEcb1Bj
POUltDoXhYrOlgWHFCC5hoRwiEsUn8ZzycCspjo9EyUbx8wl5PtjWxSEuNnnFeqL2I2D/fW1Q4Xv
vnHGGJBWsOU2LLxbUBQKqhTBpUy/HjJ/6ajPD5smG3gwggUdMIIEBaADAgECAhA6g7ce4Cw8yhzh
omQ+m2bqMA0GCSqGSIb3DQEBCwUAMIGCMQswCQYDVQQGEwJVUzEeMBwGA1UECxMVd3d3LnhyYW1w
c2VjdXJpdHkuY29tMSQwIgYDVQQKExtYUmFtcCBTZWN1cml0eSBTZXJ2aWNlcyBJbmMxLTArBgNV
BAMTJFhSYW1wIEdsb2JhbCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xNDEwMDExOTIyMzha
Fw0yNDA5MjgxOTIyMzhaMIGkMQswCQYDVQQGEwJVUzERMA8GA1UECBMISWxsaW5vaXMxEDAOBgNV
BAcTB0NoaWNhZ28xITAfBgNVBAoTGFRydXN0d2F2ZSBIb2xkaW5ncywgSW5jLjEsMCoGA1UEAxMj
VHJ1c3R3YXZlIFMvTUlNRSBTSEEyNTYgQ0EsIExldmVsIDExHzAdBgkqhkiG9w0BCQEWEGNhQHRy
dXN0d2F2ZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDhzkjmCIPTASH5G6gs
gmQPtrqYGWb5jNO1dJ58Z6NVVi2mNyWRSXgLiER9AwJRysGdTc5EdWmteL9DzZ0o0U9pzwUj1uPy
a2rRyN1IN9ckp91/nbA9edOMBLArKEm34KgmKT4XPvYoCSPGL45RKlZ1AF4BCtp1u27hQYVOA9y5
T9zCkXwnSDgIaT+xpUqSQk2mrnCql9BFiXTbkXIpvOZGOqEH9NqmgeVscxDtp6hn6q0ML55acTcC
pNQfHXhnl96CMtBGY9aqp15lp+2Gi6CVsS4e3gB7LN59MM3DJeNSJEP+fSRo01b6VywunDui7DU5
TybBDQLsug8mWOldGO87AgMBAAGjggFpMIIBZTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQW
BBQMM6NXquOr1ktwGzaeo+1hUOavdDAOBgNVHQ8BAf8EBAMCAYYwSAYDVR0gBEEwPzA9Bg8rBgEE
AYHtGAMDAwUEAwMwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly9zc2wudHJ1c3R3YXZlLmNvbS9DQTAy
BgNVHR8EKzApMCegJaAjhiFodHRwOi8vY3JsLnRydXN0d2F2ZS5jb20vWEdDQS5jcmwwbAYIKwYB
BQUHAQEEYDBeMCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC50cnVzdHdhdmUuY29tMDUGCCsGAQUF
BzAChilodHRwOi8vc3NsLnRydXN0d2F2ZS5jb20vaXNzdWVycy9YR0NBLmNydDATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBTGT6I9BmOECZzOYuQErI1ctem2GzANBgkqhkiG9w0BAQsF
AAOCAQEAh0Yse59R6DMUpUFBVazdgAgWoJwm91qTXhMxEibEmydBYvP6MhbSiULQkBNjo2DEBuMg
kDjC1b+0D6uATpZwDnLdss3dtExBUNK7pfbqGRWO/Cjj9VjKQ6nd70KqV96AkCyuoFApeRSkRtgS
aaitfGPr/vh7//HBdPPRdLQFL1xeE42VNB9/Imcx4tq6fNBLXH8y8At88IcJkJM58sObDKUq0ce7
5XYqzQdX5mvMIFFHlbcyEZNTs+k0QxDDIYX4wbl5lN3SPLE5I6NpdCbuIOHS0b+Ipll6CfkCE11o
cTvhAQdOMr614tCWjrRAYGR5zLNqSBVhn8TNqXPydDCEIDGCA+cwggPjAgEBMIG8MIGkMQswCQYD
VQQGEwJVUzERMA8GA1UECBMISWxsaW5vaXMxEDAOBgNVBAcTB0NoaWNhZ28xITAfBgNVBAoTGFRy
dXN0d2F2ZSBIb2xkaW5ncywgSW5jLjEsMCoGA1UEAxMjVHJ1c3R3YXZlIFMvTUlNRSBTSEEyNTYg
Q0EsIExldmVsIDExHzAdBgkqhkiG9w0BCQEWEGNhQHRydXN0d2F2ZS5jb20CEwbF+4ojCckhUTde
jom8evn7KgswCQYFKw4DAhoFAKCCAf8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMTcxMjIwMTAyOTI3WjAjBgkqhkiG9w0BCQQxFgQUwLSPiPc/uZ9PhpvNmWEGKoJ1
m7Ewgc0GCSsGAQQBgjcQBDGBvzCBvDCBpDELMAkGA1UEBhMCVVMxETAPBgNVBAgTCElsbGlub2lz
MRAwDgYDVQQHEwdDaGljYWdvMSEwHwYDVQQKExhUcnVzdHdhdmUgSG9sZGluZ3MsIEluYy4xLDAq
BgNVBAMTI1RydXN0d2F2ZSBTL01JTUUgU0hBMjU2IENBLCBMZXZlbCAxMR8wHQYJKoZIhvcNAQkB
FhBjYUB0cnVzdHdhdmUuY29tAhMGxfuKIwnJIVE3Xo6JvHr5+yoLMIHPBgsqhkiG9w0BCRACCzGB
v6CBvDCBpDELMAkGA1UEBhMCVVMxETAPBgNVBAgTCElsbGlub2lzMRAwDgYDVQQHEwdDaGljYWdv
MSEwHwYDVQQKExhUcnVzdHdhdmUgSG9sZGluZ3MsIEluYy4xLDAqBgNVBAMTI1RydXN0d2F2ZSBT
L01JTUUgU0hBMjU2IENBLCBMZXZlbCAxMR8wHQYJKoZIhvcNAQkBFhBjYUB0cnVzdHdhdmUuY29t
AhMGxfuKIwnJIVE3Xo6JvHr5+yoLMA0GCSqGSIb3DQEBAQUABIIBAEt6U3JUMofsJrd3NT8nkT82
NctZkOEK0AZCMfTC5zHudkByGgX7eW9QtTbeLGI3cw7J4wudaP+QFzJWezAq/OvQrjJXYljWhtyJ
XEHODnLrL0pSUl7yhPa8oF+4o+CdCfRZsWbaoBMa33wjfbqbJZG6m/nQPEtqg3JiqGp8hc3m2Evn
f27b5QMwfzlagBFghCIOrMAUzoU3QMyIfz0pWy1c9OxzxCKGbin2ihEx8voIfgZBOijTUJd6to2n
45Zg4bFHi+w2t9tva5EEo4PyT7cIDcF/zH3Fv643Jfvj5LiniVchKkq9v/JWIY3+7NOzx7+/ija3
+2/SA3PDnxA4eMsAAAAAAAA=

--Apple-Mail=_7F62D689-EC4D-401E-83CB-4642886E7BE4--
