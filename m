Received: from eggs.gnu.org ([2001:4830:134:3::10]:50209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dionbosschieter@gmail.com>) id 1ez4dJ-0000w8-Cx
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dionbosschieter@gmail.com>) id 1ez4dG-00011U-OE
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:08:13 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Dion Bosschieter <dionbosschieter@gmail.com>
In-Reply-To: <20180322173925.GA4079@localhost.localdomain>
Date: Thu, 22 Mar 2018 19:08:06 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <C80D8201-0296-4232-8987-185EF5B8BC8B@gmail.com>
References: <20180322172053.7343-1-dionbosschieter@gmail.com>
	<20180322173925.GA4079@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 1/1] block/file-posix.c: fix not reopened
 lock file descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, famz@redhat.com, qemu-block@nongnu.org

Yeah I have a use case, before a last sync on a storage migration we suspend=
 a VM -> send the last diffs -> mount the new storage server and after that w=
e change a symlink -> call reopen -> check if all file descriptors are chang=
ed before resuming the VM.

Dion

> Op 22 mrt. 2018 om 18:39 heeft Kevin Wolf <kwolf@redhat.com> het volgende g=
eschreven:
>=20
> [ Cc: qemu-block ]
>=20
> Am 22.03.2018 um 18:20 hat Dion Bosschieter geschrieben:
>> In commit 244a5668106297378391b768e7288eb157616f64 another
>> file descriptor to BDRVRawState is added. When we try to issue the
>> reopen command only s->fd is reopened; lock_fd could still hold an old
>> file descriptor "possibly" pointing to another file.
>>=20
>> - change raw_reopen_prepare so it checks use_lock from BDRVRawState and
>> tries to reopen lock_fd accordingly
>> - change raw_reopen_commit so it closes the old lock_fd on use_lock
>>=20
>> Signed-off-by: Dion Bosschieter <dionbosschieter@gmail.com>
>=20
> bdrv_reopen() is not meant for opening a different file, it is meant to
> change the flags and options of the same file. Do you have a use case
> where you would actually need to switch to a different file?
>=20
> As far as I know, lock_fd was specifically introduced _because_ it stays
> the same across reopen, so we don't need a racy release/reacquire pair.
> Fam (CCed) should know more.
>=20
> In any case, doesn't your patch drop all the locks without reacquiring
> them on the new lock_fd?
>=20
> Kevin
>=20
>> block/file-posix.c | 25 +++++++++++++++++++++++++
>> 1 file changed, 25 insertions(+)
>>=20
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index d7fb772c14..16d83fc49e 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -167,6 +167,7 @@ typedef struct BDRVRawState {
>>=20
>> typedef struct BDRVRawReopenState {
>>     int fd;
>> +    int lock_fd;
>>     int open_flags;
>> } BDRVRawReopenState;
>>=20
>> @@ -795,6 +796,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,=

>>     raw_parse_flags(state->flags, &rs->open_flags);
>>=20
>>     rs->fd =3D -1;
>> +    rs->lock_fd =3D -1;
>>=20
>>     int fcntl_flags =3D O_APPEND | O_NONBLOCK;
>> #ifdef O_NOATIME
>> @@ -820,6 +822,17 @@ static int raw_reopen_prepare(BDRVReopenState *state=
,
>>                 rs->fd =3D -1;
>>             }
>>         }
>> +
>> +        if (s->use_lock) {
>> +            rs->lock_fd =3D qemu_dup(s->lock_fd);
>> +            if (rs->lock_fd >=3D 0) {
>> +                ret =3D fcntl_setfl(rs->lock_fd, rs->open_flags);
>> +                if (ret) {
>> +                    qemu_close(rs->lock_fd);
>> +                    rs->lock_fd =3D -1;
>> +                }
>> +            }
>> +        }
>>     }
>>=20
>>     /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open() *=
/
>> @@ -835,6 +848,14 @@ static int raw_reopen_prepare(BDRVReopenState *state=
,
>>                 error_setg_errno(errp, errno, "Could not reopen file");
>>                 ret =3D -1;
>>             }
>> +
>> +            if (s->use_lock) {
>> +                rs->lock_fd =3D qemu_open(normalized_filename, rs->open_=
flags);
>> +                if (rs->lock_fd =3D=3D -1) {
>> +                    error_setg_errno(errp, errno, "Could not reopen file=
 for locking");
>> +                    ret =3D -1;
>> +                }
>> +            }
>>         }
>>     }
>>=20
>> @@ -861,7 +882,11 @@ static void raw_reopen_commit(BDRVReopenState *state=
)
>>     s->open_flags =3D rs->open_flags;
>>=20
>>     qemu_close(s->fd);
>> +    if (s->use_lock) {
>> +        qemu_close(s->lock_fd);
>> +    }
>>     s->fd =3D rs->fd;
>> +    s->lock_fd =3D rs->lock_fd;
>>=20
>>     g_free(state->opaque);
>>     state->opaque =3D NULL;
>> --=20
>> 2.14.2
>>=20
