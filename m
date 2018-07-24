Received: from eggs.gnu.org ([2001:4830:134:3::10]:47532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhveS-0007LR-Qb
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhveR-0001tA-QD
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:38:48 -0400
References: <1531927703-9799-1-git-send-email-thuth@redhat.com>
	<20180723143340.GJ8817@localhost.localdomain>
	<044fbf92-3f8f-c627-29bf-41653b60cf78@redhat.com>
	<20180724104905.GA4335@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b42cfac1-c189-60d4-f9eb-689142b2f1d4@redhat.com>
Date: Tue, 24 Jul 2018 13:38:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180724104905.GA4335@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/vvfat: Fix crash when reporting
 error about too many files in directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

On 24.07.2018 12:49, Kevin Wolf wrote:
> Am 24.07.2018 um 11:56 hat Thomas Huth geschrieben:
>> On 23.07.2018 16:33, Kevin Wolf wrote:
>>> Am 18.07.2018 um 17:28 hat Thomas Huth geschrieben:
>>>> When using the vvfat driver with a directory that contains too many =
files,
>>>> QEMU currently crashes. We are trying to print the wrong path variab=
le here.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  block/vvfat.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/vvfat.c b/block/vvfat.c
>>>> index fc41841..6ae7458 100644
>>>> --- a/block/vvfat.c
>>>> +++ b/block/vvfat.c
>>>> @@ -975,8 +975,7 @@ static int init_directories(BDRVVVFATState* s,
>>>>          if (mapping->mode & MODE_DIRECTORY) {
>>>>              mapping->begin =3D cluster;
>>>>              if(read_directory(s, i)) {
>>>> -                error_setg(errp, "Could not read directory %s",
>>>> -                           mapping->path);
>>>> +                error_setg(errp, "Could not read directory \"%s\"",=
 s->path);
>>>
>>> Hm, I'm not sure if that's right. Before this patch we were printing
>>> the name of the subdirectory that couldn't be loaded, now it's the
>>> parent directory.
>>>
>>> My test case where this difference is visible is a subdirectory with
>>> chmod 000.
>>
>> Right.
>>
>>>>                  return -1;
>>>>              }
>>>>              mapping =3D array_get(&(s->mapping), i);
>>>
>>> Maybe the right solution would be moving the reloading of mapping to
>>> between the read_directory() call and the error path?
>>
>> No, that does not work either. The problem seems to be that
>> read_directory() is changing the mapping->path pointer to something
>> invalid in between, but I've been unable to track it down where it
>> happens. This patch here seems to work for me, though:
>>
>> diff --git a/block/vvfat.c b/block/vvfat.c
>> index fc41841..f2e7d50 100644
>> --- a/block/vvfat.c
>> +++ b/block/vvfat.c
>> @@ -973,10 +973,10 @@ static int init_directories(BDRVVVFATState* s,
>>          mapping =3D array_get(&(s->mapping), i);
>>
>>          if (mapping->mode & MODE_DIRECTORY) {
>> +            char *path =3D mapping->path;
>>              mapping->begin =3D cluster;
>>              if(read_directory(s, i)) {
>> -                error_setg(errp, "Could not read directory %s",
>> -                           mapping->path);
>> +                error_setg(errp, "Could not read directory %s", path)=
;
>>                  return -1;
>>              }
>>              mapping =3D array_get(&(s->mapping), i);
>>
>> Does this look reasonable for you, too?
>=20
> I can't say I understand what's going on (the change I suggested did
> work for my test case, without valgrind errors), but the above patch
> doesn't look wrong to me at least.

FWIW, my test:

mkdir /tmp/vvfattest
cd /tmp/vvfattest
for ((x=3D0;x<=3D513;x++)); do mkdir $x; done
qemu-system-x86_64 -drive \
 file.driver=3Dvvfat,file.dir=3D.,read-only=3Don,media=3Dcdrom

I'll send a proper patch with above suggestion.

 Thomas
