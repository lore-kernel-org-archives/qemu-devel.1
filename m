Received: from eggs.gnu.org ([2001:4830:134:3::10]:45132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdw7W-0001JX-D4
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdw7V-0007gs-EL
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:20:18 -0400
References: <1531409463-3843-1-git-send-email-thuth@redhat.com>
	<1531409463-3843-2-git-send-email-thuth@redhat.com>
	<20180712165224.GD31657@localhost.localdomain>
	<224a0bbb-9dbb-87eb-9e9b-1c82923010b5@redhat.com>
	<e034610d-9a1d-a8a5-ee92-b2e3f0ba2891@redhat.com>
	<1b9c5145-881c-2385-6b91-a3c56ddcae2f@redhat.com>
	<e9e3219f-abdd-2ef5-c7f7-50807b063b0c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9351138f-0316-7a23-356a-8d3a9c93e759@redhat.com>
Date: Fri, 13 Jul 2018 13:20:07 +0200
MIME-Version: 1.0
In-Reply-To: <e9e3219f-abdd-2ef5-c7f7-50807b063b0c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] qom/object: Add a new function
 object_initialize_as_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 13.07.2018 12:12, Paolo Bonzini wrote:
> On 13/07/2018 09:57, Thomas Huth wrote:
>> Since we are in hard freeze already, I'd rather prefer to keep it
>> simple, without the variable args for now (we don't need them yet).
>> Especially since we can easily add them later when we need them,
>> changing the prototype from
>>
>> void object_initialize_child(Object *parentobj, const char *propname,
>>                              void *childobj, size_t size,
>>                              const char *type, Error **errp);
>>
>> to
>>
>> void object_initialize_child(Object *parentobj, const char *propname,
>>                              void *childobj, size_t size,
>>                              const char *type, Error **errp, ...);
>>
>> should not affect any of the existing caller sites later.
>>
>> And yes, I think these functions should have "child" in their names, s=
o
>> I'll continue with object_initialize_child now. Renaming
>> object_new_with_props to object_new_child also sounds like a good idea
>> to me, but that's something for the time when the hard freeze is over.
>=20
> It's true that we are in hard freeze, but now that I've noticed the
> parallel with object_new_with_props, it seems to me that making the
> functions subtly different (in naming or functionality) is just being
> sloppy.  A search-and-replace patch is acceptable for hard freeze if
> there is a good reason for it, and the rest is just copying code from
> object_new_with_props into the no-malloc version.  The variable
> arguments are handled simply by
>=20
>     if (object_set_propv(obj, &local_err, vargs) < 0) {
>         goto error;
>     }
>=20
> and another thing to do is
>=20
>     if (object_dynamic_cast(obj, TYPE_USER_CREATABLE)) {
>         user_creatable_complete(obj, &local_err);
>         if (local_err) {
>             object_unparent(obj);
>             goto error;
>         }
>     }
Maybe. But I doubt that I've got enough spare time to implement and test
this before the next rc. So if anybody wants to see the fixes in the
next rc already, please pick up the v2 series. Otherwise, I'll have a
closer look next week.

 Thomas
