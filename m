Received: from eggs.gnu.org ([2001:4830:134:3::10]:57045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCGfp-000560-OK
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 00:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCGfn-0008Cx-8e
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 00:09:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCGfk-00081l-6O
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 00:09:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AC213082A33
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 04:09:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
	<20181015115309.17089-34-armbru@redhat.com>
	<31daa4d5-96bf-ac50-7a3d-e503b13c9872@redhat.com>
	<eb19a7c5-7d26-a9ea-8992-44c34a16114f@redhat.com>
Date: Tue, 16 Oct 2018 06:09:26 +0200
In-Reply-To: <eb19a7c5-7d26-a9ea-8992-44c34a16114f@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	16 Oct 2018 00:38:47 +0200")
Message-ID: <87sh16v8g9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 33/35] blockdev: Convert drive_new() to
 Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 15/10/2018 16:48, Max Reitz wrote:
>> On 15.10.18 13:53, Markus Armbruster wrote:
>>> Calling error_report() from within a function that takes an Error **
>>> argument is suspicious.  drive_new() calls error_report() even though
>>> it can run within drive_init_func(), which takes an Error ** argument.
>>> drive_init_func()'s caller main(), via qemu_opts_foreach(), is fine
>>> with it, but clean it up anyway:
>>>
>>> * Convert drive_new() to Error
>>>
>>> * Update add_init_drive() to report the error received from
>>>   drive_new()
>>>
>>> * Make main() pass &error_fatal through qemu_opts_foreach(),
>>>   drive_init_func() to drive_new()
>>>
>>> * Make default_drive() pass &error_abort through qemu_opts_foreach(),
>>>   drive_init_func() to drive_new()
>>>
>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>> Cc: Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  blockdev.c                | 27 ++++++++++++++-------------
>>>  device-hotplug.c          |  5 ++++-
>>>  include/sysemu/blockdev.h |  3 ++-
>>>  vl.c                      |  8 ++++----
>>>  4 files changed, 24 insertions(+), 19 deletions(-)
>>=20
>> [...]
>>=20
>>> diff --git a/vl.c b/vl.c
>>> index 65366b961e..22beca29d1 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>=20
>> [...]
>>> @@ -4396,7 +4395,8 @@ int main(int argc, char **argv, char **envp)
>>>                            NULL, NULL);
>>>      }
>>>      if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
>>> -                          &machine_class->block_default_type, NULL)) {
>>> +                          &machine_class->block_default_type, &error_f=
atal)) {
>>> +        /* We printed help */
>>>          exit(1);
>>>      }
>>=20
>> I thought you wanted it to become an exit(0)?  I don't care either way,
>
> Markus did it in the next patch ;)

I noticed I was about to start a commit message paragraph with "Also",
and split the patch :)

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!
