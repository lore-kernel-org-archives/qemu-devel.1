Received: from eggs.gnu.org ([2001:4830:134:3::10]:60463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d8SuW-0001s4-1Z
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d8SuR-0008VE-CB
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:48:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d8SuR-0008Ut-3M
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:48:11 -0400
References: <1494398933-8366-1-git-send-email-thuth@redhat.com>
	<20170510090841.GF31558@redhat.com>
	<e8f7410f-98d9-2e0e-b75d-0ff38fd81b35@redhat.com>
	<20170510103153.GI31558@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ccb8fecd-e918-1cc0-28ef-af9865540fbc@redhat.com>
Date: Wed, 10 May 2017 16:47:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170510103153.GI31558@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Deprecate the machines pc-0.10 to
 pc-0.15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com

On 10.05.2017 12:31, Daniel P. Berrange wrote:
> On Wed, May 10, 2017 at 12:05:16PM +0200, Thomas Huth wrote:
>> On 10.05.2017 11:08, Daniel P. Berrange wrote:
[...]
>>>   - Do we really think that we still have users with VMs that are
>>>     stuck on a 6 year old machine type from 18 major releases ago ?
>>>
>>>   - Is 6 years / 18 major releases going to be our cutoff point for
>>>     machine types going forward ?
>>>
>>>   - Do we have any confidence that pc-1.0 in QEMU 2.9.0 really is
>>>     migration compatible with pc-1.0 from QEMU 1.0 ? I'm doubtful
>>>     unless someone can show automated testing results that confirm
>>>     it is compatible.
>>
>> See https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05837.htm=
l
>> ... there might be still users of 0.12  and 1.0 (though I don't hope
>> so), and everything before QEMU 1.2 can't be (life-)migrated anymore, =
so
>> we can nuke 0.10 and 0.11 for sure, maybe also the others up to 1.2.
>> So starting with a deprecation warning for 0.xx sounded like a good id=
ea
>> to me.
>=20
> If 1.2 and old is known to be broken we should just deprecate those
> immediately now. It is pointless keeping something around that is
> known broken.

Thinking about this again - yeah, you're right. I'll send a v2 of my
patch that deprecates 1.0 - 1.2, too.

>>> Also unless we're going to get more serious about automated testing t=
o
>>> validate machine type compatibility between *all* previously releases=
,
>>> I think that 6 years / 18 releases is too long a time to have any
>>> confidence in migration compatibility between versions.
>>
>> Distro vendors often offer 5 - 10 years support for certain versions o=
f
>> their Linux distros, so I think we should at least support 5 years, to=
o.
>=20
> We have two distinct needs in that area.
>=20
> RHEL has ignored upstream machine types & defined its own forever, so
> we don't need to keep pc-xxxx machines around to help RHEL. Ubuntu has
> more recently started defining custom machine types too.
>=20
> If, however, we also started deleting the underlying features (rombar=3D=
0)
> that RHEL needs in order to create its custom machine types, then that
> would cause downstream problems. For example RHEL-7.4 with QEMU 2.9.0
> tries to provide a "rhel6.0.0" machine type for compatibility with
> old QEMU 0.12 version it orginally shipped.

But isn't the whole point of deprecating features in upstream that we
can get rid of this legacy cruft like rombar=3D0 ? Also, how do you
determine whether you can finally remove such a feature from the
upstream code? Go through all long-term supported distros and ask
around? I think that is not really feasible...

> So while we can delete pc-0.12, we can't delete associated features nee=
ded
> by pc-0.12, without complicating RHEL's ability to create its back-comp=
at
> machine types. Downstream would have to un-delete the features.

So I guess this is why Paolo said that pc-0.12 is still in "use" ... I
think removing pc-0.12, but not removing rombar=3D0 will cause confusion
in the upstream code base sooner or later, so I guess we should rather
keep the pc-0.12 machine until we can get rid of it together with the
rombar code. We should still mark it as deprecated, of course.

>>> IOW, I think you should be more aggressive in culling old machine typ=
es
>>> that this patch is...
>>
>> Actually, I like the idea of using the major release versions for
>> defining the set of removal - hoping that we will do a v3.0 next year
>> which then would support the previous two major release versions 1.x a=
nd
>> 2.x, but drops support for the 0.xx versions completely ...
>=20
> I think tieing removal to major versions is a mistake, unless we're
> going to set a fixed timeframe for delivery of major versions. ie if
> we gaurantee that we'll ship a new major version every 18 months, that
> gives people a predictable lifetime.  If we carry on inventing reasons
> for major versions at arbitrary points in time, it makes it difficult
> to have any reasonable forward planning.  It is more users friendly if
> we can set a clear fixed timeframe for machine type lifecycle / eol

IMHO we should have a new major release after we've reached a .9 minor
release, but so far it seems like I'm the only one with that wish...

 Thomas
