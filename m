Received: from eggs.gnu.org ([2001:4830:134:3::10]:56058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d8UEA-00076r-45
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d8UE9-0001hB-1V
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:12:38 -0400
References: <1494431442-25163-1-git-send-email-thuth@redhat.com>
	<51843a32-50ee-391c-0377-a9b7db470ed1@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c8e08409-3b6d-6b65-37f9-ea17381e687c@redhat.com>
Date: Wed, 10 May 2017 18:12:25 +0200
MIME-Version: 1.0
In-Reply-To: <51843a32-50ee-391c-0377-a9b7db470ed1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] blockdev: Print a warning for legacy drive
 options that belong to -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org

On 10.05.2017 17:55, Paolo Bonzini wrote:
>=20
>=20
> On 10/05/2017 17:50, Thomas Huth wrote:
>> We likely do not want to carry these legacy -drive options along forev=
er.
>> Let's emit a deprecation warning for the -drive options that have a
>> replacement with the -device option, so that the (hopefully few) remai=
ning
>> users are aware of this and can adapt their scripts / behaviour.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  blockdev.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index 4d8cded..87a025a 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -797,6 +797,9 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInte=
rfaceType block_default_type)
>>      const char *filename;
>>      Error *local_err =3D NULL;
>>      int i;
>> +    const char *deprecated[] =3D {
>> +        "serial", "trans", "secs", "heads", "cyls"
>> +    };
>> =20
>>      /* Change legacy command line options into QMP ones */
>>      static const struct {
>> @@ -880,6 +883,14 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInt=
erfaceType block_default_type)
>>                  "update your scripts.\n");
>>      }
>> =20
>> +    /* Other deprecated options */
>> +    for (i =3D 0; i < ARRAY_SIZE(deprecated); i++) {
>> +        if (qemu_opt_get(legacy_opts, deprecated[i]) !=3D NULL) {
>> +            error_report("'%s' is deprecated, please use the correspo=
nding "
>> +                         "option of '-device' instead", deprecated[i]=
);
>> +        }
>> +    }
>> +
>>      /* Media type */
>>      value =3D qemu_opt_get(legacy_opts, "media");
>>      if (value) {
>=20
> This one should be deprecated too (separate patch if you prefer).

I tried to add it, but then the deprecation message is always shown. I
think this happens because of the default CD-ROM drive is create in vl.c
with CDROM_OPTS (that is defined to "media=3Dcdrom").
So no clue how to properly print a deprecation option for "media" here
right now (and it should likely be in a separate patch if there is a
solution).

 Thomas
