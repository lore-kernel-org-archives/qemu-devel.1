Received: from eggs.gnu.org ([2001:4830:134:3::10]:39115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eouxr-0002xv-KK
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eouxp-0003N0-Pm
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:47:27 -0500
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-4-mreitz@redhat.com>
	<20180222133956.GG4147@localhost.localdomain>
	<a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
	<20180222151210.GK4147@localhost.localdomain>
	<c5a34045-7c8f-f37b-8fc6-a5338cedc2bf@redhat.com>
	<20180222162147.GL4147@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <26a949be-bc67-7fef-3e66-59e9d7268cad@redhat.com>
Date: Thu, 22 Feb 2018 18:47:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180222162147.GL4147@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hfMObxSYzFWdRex7jGG2c1hD1kSqaxhWC"
Subject: Re: [Qemu-devel] [PATCH v8 03/26] block: Add BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hfMObxSYzFWdRex7jGG2c1hD1kSqaxhWC
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Alberto Garcia <berto@igalia.com>
Message-ID: <26a949be-bc67-7fef-3e66-59e9d7268cad@redhat.com>
Subject: Re: [PATCH v8 03/26] block: Add BDS.backing_overridden
References: <20180205151835.20812-1-mreitz@redhat.com>
 <20180205151835.20812-4-mreitz@redhat.com>
 <20180222133956.GG4147@localhost.localdomain>
 <a28d1832-cdf2-3413-a0f3-a885dfaa2375@redhat.com>
 <20180222151210.GK4147@localhost.localdomain>
 <c5a34045-7c8f-f37b-8fc6-a5338cedc2bf@redhat.com>
 <20180222162147.GL4147@localhost.localdomain>
In-Reply-To: <20180222162147.GL4147@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-02-22 17:21, Kevin Wolf wrote:
> Am 22.02.2018 um 16:17 hat Max Reitz geschrieben:
>> On 2018-02-22 16:12, Kevin Wolf wrote:
>>> Am 22.02.2018 um 15:55 hat Max Reitz geschrieben:
>>>> On 2018-02-22 14:39, Kevin Wolf wrote:
>>>>> Am 05.02.2018 um 16:18 hat Max Reitz geschrieben:
>>>>>> If the backing file is overridden, this most probably does change =
the
>>>>>> guest-visible data of a BDS. Therefore, we will need to consider t=
his in
>>>>>> bdrv_refresh_filename().
>>>>>>
>>>>>> Adding a new field to the BDS is not nice, but it is very simple a=
nd
>>>>>> exactly keeps track of whether the backing file has been overridde=
n.
>>>>>
>>>>> ...as long as we manage to actually keep it up to date all the time=
=2E
>>>>>
>>>>> First of all, what I'm missing here (or in fact in the comment in t=
he
>>>>> code) is a definition what "overridden" really means. "specified by=
 the
>>>>> user" is kind of vague: You consider the backing file relationship =
for
>>>>> snapshot=3Don as user specified, even though the user wasn't explic=
it
>>>>> about this. On the other hand, creating a live snapshot results in =
a
>>>>> node that isn't user specified.
>>>>>
>>>>> Isn't the real question to ask whether the default backing file (ta=
ken
>>>>> from the image header) would result in the same tree? The answer to=
 this
>>>>> changes after more operations, like qmp_change_backing_file().
>>>>
>>>> With you so far.
>>>>
>>>>> Considering that there are so many ways to change the answer, I thi=
nk
>>>>> the simplest reliable option isn't a new BDS field that needs to up=
dated
>>>>> everywhere, but looking at the current value of bs->options and
>>>>> bs->backing_file and see if they match.
>>>>
>>>> I don't see how that is simple.  First, bs->options does not necessa=
rily
>>>> reflect the "current options", those would be bs->full_open_options.=

>>>> And for generating that, we need a way to determine whether the back=
ing
>>>> file has been overridden or not, so whether we need to put the backi=
ng
>>>> options into it or whether we do not.
>>>
>>> For the purpose of this comparison, we need a set of options that
>>> contains the backing file options unconditionally.
>>>
>>>> (I am right that bs->backing_file is what the image header says, rig=
ht?
>>>> So we need to compare it against something that reflects the runtime=
 state.)
>>>
>>> I think so, yes.
>>>
>>>> What I could see would be comparing bs->backing_file to
>>>> bs->backing->bs->filename.  But this sounds very hacky to me.
>>>>
>>>> One thing the comes to mind is that it can break whenever
>>>> bdrv_refresh_filename() is clever.  So you specify
>>>> 'json:{"driver":"null-co"}' in the image header, and
>>>> bdrv_refresh_filename() optimizes that to "null-co://".  Now the
>>>> filenames differ even though it's still the original filename.  So t=
his
>>>> wouldn't work very well either.
>=20
> So what's the full effect here?
>=20
> You example says that if you use an overcomplicated way to specify an
> image (by using json: instead of an URL), you get back an
> overcomplicated filename for the parent image (which includes the
> backing file even though it's not really necessary). Sounds fair enough=

> to me.

OK, but one issue is that you've used an overcomplicated way for the
backing file; but you get an overcomplicated filename for the overlay.

> Can bad things happen with absolute vs. relative paths?

"Can"?  Absolutely.  "Do"?  I don't know? :-)

Another thing are non-unique URLs.  For instance, nbd allows you to
specify "nbd:localhost:10809", but it will generate
"nbd://localhost:10809".  (Same for just "nbd://localhost".)

Or of course the good old "file:foo.qcow2".

>>> On the other hand, the problem with your current approach is that it
>>> results in a JSON filename even if you override the backing file and
>>> specify the same file name as we already have in the image header.
>>
>> Yes.
>>
>>> In the future, libvirt is going to manually build the graph, so we wi=
ll
>>> always have the backing file overridden according to the logic in thi=
s
>>> patch. I don't think we want to get JSON filenames for all libvirt
>>> managed VMs, so can we realistically do without any kind of compariso=
n?
>>
>> libvirt doesn't need to query the filename, though, does it?
>=20
> I know that libvirt uses the output in qemu-img info. And I learnt abou=
t
> that because they were surprised that json: filenames you get there
> can't necessarily be fed to QMP (because they contain only strings).
>=20
> Other than that, I hope they don't. I suppose the filename can end up i=
n
> error messages in logfiles, though.

Fair point.  Although it isn't impossible to decrypt json:{} filenames,
it isn't very nice.

(And I suspect most error messages today actually contain the node name,
which is even less useful than json:{} filenames.)

>> In my mind, we wanted to phase out filenames and basically only presen=
t
>> them as convenience/legacy information to users who use qemu directly.=

>>
>> I really don't see the point of burdening qemu with simplifying and
>> niceifying filenames when you want to use node names for everything
>> anyway.
>=20
> But if you essentially say "filenames are only for those who don't use
> advanced features", then why bother with overridden backing files?

Because giving overcomplicated information is better than giving plainly
wrong information.

If we return a filename, it has to be correct.  Sure, we could just not
return filenames, but even then we would need to have a way of
recognizing when to do that.

But given backwards compatibility and all, I can't imagine a way where
we don't have to deal with the backing file issue in one way or another.

If you want to remove filenames from the internal state and for what
queries return (apart from bs->options for protocol nodes) in 3.0, sign
me up for it.

> There are two problems I have with this patch: The first is that it
> introduces additional state that needs to be managed correctly in all
> future patches that modify the graph, and the second (and worse one) is=

> that it fails to manage this state correctly even now.

Well, agreed.  I know there were a couple revisions already where I
fixed things.

But then again, I also seem to remember that I've had a discussion about
what to do here with you before, but it's been so long that I can't
remember the actual content.

> I mentioned snapshots and change-backing-file that can result in a wron=
g
> bs->backing_overridden, and those were only the obvious first places I
> had a look at. Even if you fix them, I wouldn't trust my own review to
> find all relevant places. And that's a really bad sign for a design.
>=20
> This is the most important reason why I'm looking for some method to
> derive the flag from already existing state.

The only things I can say to that are "I agree" and "I've tried before".
 The thing is, I started working on this series in November 2015
(apparently), so I've completely forgotten what exactly it was that I
tried and I only know that my result was "I'll have to add this field".

I concede that result may be wrong, and I myself sure hope so.

So thee two things I see now are:

(1) Compare bs->backing_file against bs->backing->bs->filename.  Seems
basically as error-prone as backing_overridden to me, probably not only
because bdrv_refresh_filename() may change .filename.

(2) Keep backing_overridden; but we'd need a central point for changing
bs->backing, i.e. two functions or one function with a boolean
parameter.  That parameter tells it whether we want to change the
current backing file, independently of the file's metadata, or whether
we want to change the backing file in accordance with the file's
metadata.  In the former case, we'd set backing_overridden, in the
latter, we'd clear it.  This function would then be the only one allowed
to modifiy bs->backing.  The issue here is that maybe it's still not as
simple as it sounds, and it is still possible to have backing_overridden
set even though the backing node is indeed what it would be without the
@backing option specified -- but I personally don't see a simple way to
support this.

(We could strcmp bs->backing_file and bs->backing->bs->filename and if
they match, we clear backing_overridden even though it is supposed to be
set.  But that would mean inconsistent behavior (sometimes you're lucky,
sometimes you aren't), and I don't like that very much.  I actually
prefer consistently undesirable behavior over inconsistently desirable
behavior.)

Max


--hfMObxSYzFWdRex7jGG2c1hD1kSqaxhWC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPAhYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ArUsH/0IEMfCuqe5I0NTgcIyo08oiO1Pq6cAR
MTSdT4MmRAhTL6xCoaS7yJ33tugDv1MsjF6ALIkuszZ661+ZIZDMWIpH2h6NSxvk
xcGZNK56nMMXgvdjcs9Tt948eLKGDtaBFpRXrTgSyo/t0nmJDMLgFuPcyXGWV7Zo
saKwtX5561nSHbTc63Q27mxm/OIOfITP6c4PV71NK/yuEFGNEQa4SUGGY6wf4fX9
4uqtiRrUuwb5Yxflxrek8bx8tLWkkx13Bftu8R3OoZZO78hs5J5QfEhHYpXJHEqb
J/Pt/7idEs6UhGvwK4C7CzpMuZVWC0qwBR7pMrOfjXAd+Aj2dcjHrSA=
=5WY0
-----END PGP SIGNATURE-----

--hfMObxSYzFWdRex7jGG2c1hD1kSqaxhWC--
