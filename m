Received: from eggs.gnu.org ([209.51.188.92]:36685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghHoM-00042R-Nf
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghHoL-0006X5-6g
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:38:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ghHoK-0006VC-Sw
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:38:37 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
Date: Wed, 9 Jan 2019 18:38:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190109172023.GK4867@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IAws6MXONgr3kcOxXvEjBOtqi1F0eFQr5"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IAws6MXONgr3kcOxXvEjBOtqi1F0eFQr5
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com
Message-ID: <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
Subject: Re: [PATCH v2 0/3] HMP/snapshot changes - do not use ID anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
 <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
 <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
 <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
 <20190109172023.GK4867@localhost.localdomain>
In-Reply-To: <20190109172023.GK4867@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09.01.19 18:20, Kevin Wolf wrote:
> Am 09.01.2019 um 18:05 hat Max Reitz geschrieben:
>> On 09.01.19 17:57, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 1/9/19 12:10 PM, Max Reitz wrote:
>>>> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
>>>>> changes in v2:
>>>>> - removed the "RFC" marker;
>>>>> - added a new patch (patch 2) that removes
>>>>> bdrv_snapshot_delete_by_id_or_name from the code;
>>>>> - made changes in patch 1 as suggested by Murilo;
>>>>> - previous patch set link:
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html=

>>>>>
>>>>>
>>>>> It is not uncommon to see bugs being opened by testers that attempt=
 to
>>>>> create VM snapshots using HMP. It turns out that "0" and "1" are qu=
ite
>>>>> common snapshot names and they trigger a lot of bugs. I gave an exa=
mple
>>>>> in the commit message of patch 1, but to sum up here: QEMU treats t=
he
>>>>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'=
=2E It
>>>>> is documented as such, but this can lead to strange situations.
>>>>>
>>>>> Given that it is strange for an API to consider a parameter to be 2=

>>>>> fields
>>>>> at the same time, and inadvently treating them as one or the other,=
 and
>>>>> that removing the ID field is too drastic, my idea here is to keep =
the
>>>>> ID field for internal control, but do not let the user set it.
>>>>>
>>>>> I guess there's room for discussion about considering this change a=
n API
>>>>> change or not. It doesn't affect users of HMP and it doesn't affect=

>>>>> Libvirt,
>>>>> but simplifying the meaning of the parameters of savevm/loadvm/delv=
m.
>>>> (Yes, very late reply, I'm sorry...)
>>>>
>>>> I do think it affects users of HMP, because right now you can delete=

>>>> snapshots with their ID, and after this series you cannot.
>>>
>>> That's true. My idea here was simple: the user can't reliably exclude=

>>> via snapshot ID today
>>> because we're hiding the ID field in info snapshots:
>>>
>>>
>>> =A0=A0=A0 (qemu) savevm 0
>>> =A0=A0=A0 (qemu) info snapshots
>>> =A0=A0=A0 List of snapshots present on all disks:
>>> =A0=A0=A0 ID=A0=A0=A0=A0=A0=A0=A0 TAG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 VM SIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DATE=
 VM CLOCK
>>> =A0=A0=A0 --=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 741M 2018-07-31 13:39:56 00:41:25.313
>>>
>>>
>>> Thus, what will end up happening is that the user will be forced to u=
se the
>>> TAG of the snapshot since this is the only available information.
>>
>> But you can get it through e.g. qemu-img info.
>>
>> Snapshot list:
>> ID        TAG                 VM SIZE                DATE       VM CLO=
CK
>> 1         0                      1.6M 2019-01-09 18:01:21   00:00:02.6=
57
>>
>> So it's not impossible to get.
>=20
> Is there a reason why we should display the ID at all when you can't us=
e
> it any more to identify snapshots?

I thought the long-term goal of this series really was to remove all
mentions of the ID, yes.

>>>> I think we had a short discussion about just disallowing numeric
>>>> snapshot names.=A0 How bad would that be?
>>>
>>>
>>> This was my first idea when evaluating what to do in this case. I gav=
e
>>> it up because
>>> I found it to be too extreme. People would start complaining "I was a=
ble
>>> to do
>>> savevm 0 and now I can't".
>>
>> True.  But it wouldn't be impossible to do, we'd need to deprecate
>> numeric names, print a warning for two releases, and then we can make =
it
>> an error.
>=20
> This. Is. HMP.
>=20
> Not a stable ABI, no deprecation period of two releases.

Well, if you want to do it.

This may be HMP, but this is also the only interface to savevm, so it's
not like users have a choice to use a more stable interface.  I know
that was a conscious decision, more or less, but I don't see why we need
to be so nasty when the hardest thing about doing a nice deprecation
would be to remember to make it an error in half a year.

>> Hm...  If we had a proper deprecation warning in this series, I suppos=
e
>> it wouldn't be dangerous anymore.  Can we just print a warning wheneve=
r
>> the user specified an ID?  (i.e. if some snapshot's ID matches the
>> string given by the user and the snapshot's name does not)
>=20
> How is it less of a problem when a user gets QEMU from the distro and
> skips five releases? They will never see the warning. This is different=

> from QMP where things are fixed in libvirt, which is tested with every
> single QEMU release.

Well, then allowing users to accidentally specify the wrong snapshot
remains adventurous.

The thing is that this really is the only interface to savevm.  So while
it may be HMP, it probably won't be used only by plain human end users
who just don't want to deal with QMP.  I can imagine it is used with
scripts and by people who regularly update their qemu because they have
something important running on top of it.

<general whining>
Actually, to me what you're saying sounds more like "Our deprecation
policy is useless" to which I wholeheartedly agree.  I think we should
only remove things in major releases, and only if it was deprecated in
the previous major release already.  (So if you deprecate something in
4.0, you can remove it in 5.0; but if you deprecate it in 4.1, you can
remove it only in 6.0.)  From a user standpoint I really think we
deprecate stuff too irregularly.
</general whining>

OK, anyway, you're talking about stable distros.  But there are other
users, too, so yes, this is less of a problem because it is a problem
only for users of stable distros; so it's a problem for less users.


But anyway, if you think deprecation is futile here, then I maintain
that this series bears a bit of a risk.

Max


--IAws6MXONgr3kcOxXvEjBOtqi1F0eFQr5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2MZIACgkQ9AfbAGHV
z0D/8wgAk87gnwbPQReZMJOuiVLRyzgNEMVvfdVHSBqj43eKtE2eha0ohLc+DQgJ
pO/M0mLvUHnYzLCNcD7AHa6VFvfHUOmkVLh2rIL4j5o/3yVeC+t9Du2hO+eTe5RT
iPh9MTVGdfYax+c+7saYi2qa/2EUWt1fyQmiaHjrM8viSneF1ibIU8yMj3AUziOx
zUOCZJpFoX+5SsFFzESgaDUUxKybN2gsexkVZhaRia46A4EjYbNryjcbTejhpiJc
ADY0TL7pze0u6KwTqtLe/py8JZpSDAcjj2V91BYQxWD5TsLD4x4V1zLZH7bxv0Gy
ijSDhDyKQmQtg7SmukLtP8PjJKGdUw==
=UgyZ
-----END PGP SIGNATURE-----

--IAws6MXONgr3kcOxXvEjBOtqi1F0eFQr5--
