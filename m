Received: from eggs.gnu.org ([2001:4830:134:3::10]:55303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1dwPFm-0001bv-NW
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1dwPFj-00044v-Mz
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:00:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:42386 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afaerber@suse.de>) id 1dwPFj-00043x-Dd
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:00:35 -0400
References: <1506321449-24013-1-git-send-email-peterx@redhat.com>
	<1506321449-24013-2-git-send-email-peterx@redhat.com>
	<4540074c-f523-41f4-3ce7-8b6514060fa4@suse.de>
	<20170925081426.GE19505@pxdev.xzpeter.org>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <f8b295e1-e2c5-fdce-d4ea-2161490ca08b@suse.de>
Date: Mon, 25 Sep 2017 11:00:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170925081426.GE19505@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Hi,

Am 25.09.2017 um 10:14 schrieb Peter Xu:
> On Mon, Sep 25, 2017 at 09:14:21AM +0200, Andreas F=C3=A4rber wrote:
>> Am 25.09.2017 um 08:37 schrieb Peter Xu:
>>> We have object_get_objects_root() to keep user created objects, howev=
er
>>> no place for objects that will be used internally.  Create such a
>>> container for internal objects.
>>>
>>> CC: Andreas F=C3=A4rber <afaerber@suse.de>
>>> CC: Markus Armbruster <armbru@redhat.com>
>>> CC: Paolo Bonzini <pbonzini@redhat.com>
>>> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  include/qom/object.h | 10 ++++++++++
>>>  qom/object.c         |  5 +++++
>>>  2 files changed, 15 insertions(+)
>>>
>>> diff --git a/include/qom/object.h b/include/qom/object.h
>>> index f3e5cff..f567052 100644
>>> --- a/include/qom/object.h
>>> +++ b/include/qom/object.h
>>> @@ -1214,6 +1214,16 @@ Object *object_get_root(void);
>>>  Object *object_get_objects_root(void);
>>> =20
>>>  /**
>>> + * object_get_internal_root:
>>> + *
>>> + * Get the container object that holds internally used object
>>> + * instances. This is the object at path "/internal-objects"
>>> + *
>>> + * Returns: the internal object container
>>> + */
>>> +Object *object_get_internal_root(void);
>>> +
>>> +/**
>>>   * object_get_canonical_path_component:
>>>   *
>>>   * Returns: The final component in the object's canonical path.  The=
 canonical
>>> diff --git a/qom/object.c b/qom/object.c
>>> index 3e18537..857cee7 100644
>>> --- a/qom/object.c
>>> +++ b/qom/object.c
>>> @@ -1370,6 +1370,11 @@ Object *object_get_objects_root(void)
>>>      return container_get(object_get_root(), "/objects");
>>>  }
>>> =20
>>> +Object *object_get_internal_root(void)
>>> +{
>>> +    return container_get(object_get_root(), "/internal-objects");
>>
>> Whatever you expose in the QOM tree is no longer internal. Other name?
>=20
> Hi, Andreas,
>=20
> If you mean "info qom-tree" here, can we still treat it as internal?
> Since after all it's not exposed in QMP (while IMHO QMP is the
> official protocol for QEMU clients).  And IIUC some HMP commands do
> dump some internal structs for debugging purpose (like: "info
> ramblock").
>=20
> Or, do you have any suggestion?
>=20
> (I did think about something like "hidden-objects", but I believe they
>  are not hidden as well if we think they are not internal...)

I'm on travels and only seeing this 1/4 without context - according to
Manos apparently something about IOThreads.

The reason that certain container groups such as "/machine/peripheral"
exist was more of a legacy reason for migration from qdev, so yes I am
critical of "/hidden-objects" as well. If the objects are not related to
an existing device, you could just place them somewhere outside
"/machine", e.g. directly in the root node or in a container specific to
that use case (/io? /threads?), rather than a new generic bucket of
whatever name. Any objects not under /machine should be close to what
you consider internal.

Note that "info qom-tree" is not the only way to query the objects,
there's some Python QMP scripts as well.

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
