Received: from eggs.gnu.org ([2001:4830:134:3::10]:47788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dwOrI-0007Fk-Uk
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dwOrE-0001i7-Pl
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:35:20 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:36248)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dwOrE-0001cN-EW
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:35:16 -0400
Date: Mon, 25 Sep 2017 11:34:58 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170925083458.luy7kjv6x56lptvi@postretch>
References: <1506321449-24013-1-git-send-email-peterx@redhat.com>
	<1506321449-24013-2-git-send-email-peterx@redhat.com>
	<4540074c-f523-41f4-3ce7-8b6514060fa4@suse.de>
	<20170925081426.GE19505@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ht2aswe3wnqpunq"
Content-Disposition: inline
In-Reply-To: <20170925081426.GE19505@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qom: provide root container for
 internal objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--7ht2aswe3wnqpunq
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2017 at 04:14:26PM +0800, Peter Xu wrote:
>On Mon, Sep 25, 2017 at 09:14:21AM +0200, Andreas F=C3=A4rber wrote:
>> Am 25.09.2017 um 08:37 schrieb Peter Xu:
>> > We have object_get_objects_root() to keep user created objects, however
>> > no place for objects that will be used internally.  Create such a
>> > container for internal objects.
>> >
>> > CC: Andreas F=C3=A4rber <afaerber@suse.de>
>> > CC: Markus Armbruster <armbru@redhat.com>
>> > CC: Paolo Bonzini <pbonzini@redhat.com>
>> > Suggested-by: Daniel P. Berrange <berrange@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  include/qom/object.h | 10 ++++++++++
>> >  qom/object.c         |  5 +++++
>> >  2 files changed, 15 insertions(+)
>> >
>> > diff --git a/include/qom/object.h b/include/qom/object.h
>> > index f3e5cff..f567052 100644
>> > --- a/include/qom/object.h
>> > +++ b/include/qom/object.h
>> > @@ -1214,6 +1214,16 @@ Object *object_get_root(void);
>> >  Object *object_get_objects_root(void);
>> >
>> >  /**
>> > + * object_get_internal_root:
>> > + *
>> > + * Get the container object that holds internally used object
>> > + * instances. This is the object at path "/internal-objects"
>> > + *
>> > + * Returns: the internal object container
>> > + */
>> > +Object *object_get_internal_root(void);
>> > +
>> > +/**
>> >   * object_get_canonical_path_component:
>> >   *
>> >   * Returns: The final component in the object's canonical path.  The =
canonical
>> > diff --git a/qom/object.c b/qom/object.c
>> > index 3e18537..857cee7 100644
>> > --- a/qom/object.c
>> > +++ b/qom/object.c
>> > @@ -1370,6 +1370,11 @@ Object *object_get_objects_root(void)
>> >      return container_get(object_get_root(), "/objects");
>> >  }
>> >
>> > +Object *object_get_internal_root(void)
>> > +{
>> > +    return container_get(object_get_root(), "/internal-objects");
>>
>> Whatever you expose in the QOM tree is no longer internal. Other name?
>
>Hi, Andreas,
>
>If you mean "info qom-tree" here, can we still treat it as internal?
>Since after all it's not exposed in QMP (while IMHO QMP is the
>official protocol for QEMU clients).  And IIUC some HMP commands do
>dump some internal structs for debugging purpose (like: "info
>ramblock").
>
>Or, do you have any suggestion?
>
>(I did think about something like "hidden-objects", but I believe they
> are not hidden as well if we think they are not internal...)
>
>Thanks,
>
>>
>> Regards,
>> Andreas

If there's no need for internal IOThreads to be together with user=20
created ones, a simple queue will be enough (include/qemu/queue.h).

--7ht2aswe3wnqpunq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlnIv7IACgkQc2J8L2kN
9xAuBA//dcEVWTNCMMjRdIW7VCJZp6ZxGOduk0KAVU7OJWabMYQZTn9aMQxwV5cB
GdwaQ7dl4aJPwcLo3nH78GPitRv11uLiz1LTCkpX2J2nY8jVIZx4a7+ymji5ypqE
rDABK9RI8/IgfzfbtQZZfhxyRGYtxtH9hy+L1x1jtGTMlXrUCXMmokb9VcaEz/fO
/nsl2Y2GJqPG+KJSjO9LByOLWQJ7g/mEUnUFZl86vMj4bvr8aY1ORUpeBpDNPkCX
FY7UEXsryAcwqscxydfpUtMtA2MiMF6xWFmrqrgIWOyiKnkm+iYg14hDzvxyBjpR
IcnPn1ZQSi5kuoflzF7EOVqWyYt/uQPzjNjmgR/HMOc7m0v0WedtN5WFZ8ggpR6V
TqxkhiPUIuaCrxkIKLcp1Oxkd5QShDjlzOe2du5MdPo1pkzaM9cL/FiD9fOgH0JP
1QfzTK3n0vtQ9Ji59RUPN5FayzRYbH+tjuYItOH0KV+76/c+UFpI0Yw6NWMLi0NP
d4XyhwEA3ilKhwydSFrIJFH1xU/mjQRxrhbdtZxZN4GtT2WMTrVU3nnCIIwfb6/W
wiMHusePD35lZx9bc7Kg03riUSCErvO3M3uV+jtc7MglnrI2JyyCREM5epnTDF3L
9KUHuHm6UR2GaH4XIambSnYBO1gxn6V7I6a5BxAep/ZciLCdpvs=
=b4Xh
-----END PGP SIGNATURE-----

--7ht2aswe3wnqpunq--
