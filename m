Received: from eggs.gnu.org ([209.51.188.92]:39639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmMDf-0007ja-Aj
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmMDd-0006kx-7X
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:21:43 -0500
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
	<20190123110417.69e41c38@doriath>
	<b6fd5a23-3afc-0ba2-2e24-b6d7d53c7fc2@redhat.com>
	<20190123112420.0fe8fb0c@doriath> <20190123163553.GD2193@work-vm>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a5899bdc-b5d7-d287-5457-e9aafa613c13@redhat.com>
Date: Wed, 23 Jan 2019 18:16:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190123163553.GD2193@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GvHAlrFtRX5870d7oaHZOG3DqXHuWX5sR"
Subject: Re: [Qemu-devel] Aborts in iotest 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GvHAlrFtRX5870d7oaHZOG3DqXHuWX5sR
From: Max Reitz <mreitz@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Luiz Capitulino <lcapitulino@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a5899bdc-b5d7-d287-5457-e9aafa613c13@redhat.com>
Subject: Re: Aborts in iotest 169
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
 <20190123110417.69e41c38@doriath>
 <b6fd5a23-3afc-0ba2-2e24-b6d7d53c7fc2@redhat.com>
 <20190123112420.0fe8fb0c@doriath> <20190123163553.GD2193@work-vm>
In-Reply-To: <20190123163553.GD2193@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.19 17:35, Dr. David Alan Gilbert wrote:
> * Luiz Capitulino (lcapitulino@redhat.com) wrote:
>> On Wed, 23 Jan 2019 17:12:35 +0100
>> Max Reitz <mreitz@redhat.com> wrote:
>>
>>> On 23.01.19 17:04, Luiz Capitulino wrote:
>>>> On Wed, 23 Jan 2019 16:48:49 +0100
>>>> Max Reitz <mreitz@redhat.com> wrote:
>>>>  =20
>>>>> Hi,
>>>>>
>>>>> When running 169 in parallel (e.g. like so:
>>>>>
>>>>> $ while TEST_DIR=3D/tmp/t0 ./check -T -qcow2 169; do; done
>>>>> $ while TEST_DIR=3D/tmp/t1 ./check -T -qcow2 169; do; done
>>>>> $ while TEST_DIR=3D/tmp/t2 ./check -T -qcow2 169; do; done
>>>>> $ while TEST_DIR=3D/tmp/t3 ./check -T -qcow2 169; do; done
>>>>>
>>>>> in four different shells), I get aborts: =20
>>>>
>>>> OK, is this part of a test-suite that's also running migration
>>>> tests in parallel or in sequence? In other words, what does
>>>> iotests have to do with migration (sorry if this is stupid
>>>> question, but it's been years I don't do qemu). =20
>>>
>>> They run migration tests in sequence, but if you run multiple test
>>> instances in parallel, well, then they will be run in parallel.
>>>
>>> The only reason I CC'd you was because you were so prominent in git
>>> blame. O:-)
>>
>> Yeah, that's often the case with me :-)
>>
>>>> When this happened in the past it meant some QEMU code skipped a
>>>> transition, but I can't tell what this has to do with iotests. =20
>>>
>>> Well, this iotest (which tests a migration configuration) sometimes
>>> apparently results in this invalid transition.  But that can't be jus=
t
>>> the test's fault, as qemu should handle that gracefully.
>>
>> Does iotest run a guest or does it only executes parts of qemu
>> code? If it's the latter, then I'd guess the test code is missing
>> calling qemu code that sets the appropriate state between
>> running and postmigrate states.
>>
>>> It's probably an issue in the migration code and not so much in vl.c,=
 yes...
>>
>> Yeah, I'll let the migration people jump in.
>=20
> Can we get a log of the qmp commands when it fails?
> A 'running->postmigrate' transition is a bit weird; you could get a
> something->postmigrate if you migrate a VM twice, and the source is
> already in postmigrate, so it tells the destination to go into
> postmigrate.   That's odd in itself, but not *that* odd.
> But then why is it going running->postmigrate?  That suggests
> the source is currently running when it receives an incoming migration,=

> and that really shouldn't happen.

This is what I get with -d:

>=20
> test_do_test_migration_resume_source_persistent__not_migbitmap (__main_=
_.TestDirtyBitmapMigration) ... DEBUG:QMP:>>> {'execute': 'qmp_capabiliti=
es'}
> DEBUG:QMP:<<< {u'return': {}}
> DEBUG:QMP:>>> {'execute': 'migrate-set-capabilities', 'arguments': {'ca=
pabilities': [{'capability': 'events', 'state': True}]}}
> DEBUG:QMP:<<< {u'return': {}}
> DEBUG:QMP:>>> {'execute': 'block-dirty-bitmap-add', 'arguments': {'node=
': 'drive0', 'persistent': True, 'name': 'bitmap0', 'granularity': 512}}
> DEBUG:QMP:<<< {u'return': {}}
> DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'comma=
nd-line': 'qemu-io drive0 "write 0 65536"'}}
> DEBUG:QMP:<<< {u'return': u''}
> DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'comma=
nd-line': 'qemu-io drive0 "write 983040 65536"'}}
> DEBUG:QMP:<<< {u'return': u''}
> DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'comma=
nd-line': 'qemu-io drive0 "write 655873 4096"'}}
> DEBUG:QMP:<<< {u'return': u''}
> DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'argumen=
ts': {'node': 'drive0', 'name': 'bitmap0'}}
> DEBUG:QMP:<<< {u'return': {u'sha256': u'01d2ebedcb8f549a2547dbf8e231c41=
0e3e747a9479e98909fc936e0035cf8b1'}}
> DEBUG:QMP:>>> {'execute': 'migrate', 'arguments': {'uri': 'exec: cat > =
/tmp/t0/test-qcow2-file/mig_file'}}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': =
301029}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
> DEBUG:QMP:<<< {u'return': {}}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': =
302836}, u'data': {u'pass': 1}, u'event': u'MIGRATION_PASS'}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': =
302899}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': =
312321}, u'event': u'STOP'}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': =
312413}, u'data': {u'pass': 2}, u'event': u'MIGRATION_PASS'}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': =
314779}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
> DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'argumen=
ts': {'node': 'drive0', 'name': 'bitmap0'}}
> DEBUG:QMP:<<< {u'error': {u'class': u'GenericError', u'desc': u"Dirty b=
itmap 'bitmap0' not found"}}
> DEBUG:QMP:>>> {'execute': 'cont'}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263213, u'microseconds': =
316624}, u'event': u'RESUME'}
> DEBUG:QMP:<<< {u'return': {}}
> DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'argumen=
ts': {'node': 'drive0', 'name': 'bitmap0'}}
> WARNING:qemu:qemu received signal 6: build/tests/qemu-iotests/../../x86=
_64-softmmu/qemu-system-x86_64 -chardev socket,id=3Dmon,path=3D/tmp/t0/te=
st-qcow2-file/tmp1d4GTg/qemua-28430-monitor.sock -mon chardev=3Dmon,mode=3D=
control -display none -vga none -qtest unix:path=3D/tmp/t0/test-qcow2-fil=
e/qemua-28430-qtest.sock -machine accel=3Dqtest -nodefaults -machine acce=
l=3Dqtest -drive if=3Dvirtio,id=3Ddrive0,file=3D/tmp/t0/test-qcow2-file/d=
isk_a,format=3Dqcow2,cache=3Dwritethrough
> ERROR
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ERROR: test_do_test_migration_resume_source_persistent__not_migbitmap (=
__main__.TestDirtyBitmapMigration)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "169", line 206, in <lambda>
>     setattr(klass, 'test_' + method + name, lambda self: mc(self))
>   File "169", line 113, in do_test_migration_resume_source
>     self.check_bitmap(self.vm_a, sha256)
>   File "169", line 72, in check_bitmap
>     node=3D'drive0', name=3D'bitmap0')
>   File "tests/qemu-iotests/../../scripts/qemu.py", line 368, in qmp
>     return self._qmp.cmd(cmd, args=3Dqmp_args)
>   File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 191, in cmd
>     return self.cmd_obj(qmp_cmd)
>   File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 174, in cmd_=
obj
>     resp =3D self.__json_read()
>   File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 82, in __jso=
n_read                                                                   =
                                                                         =
                   =20
>     data =3D self.__sockfile.readline()
>   File "/usr/lib64/python2.7/socket.py", line 451, in readline
>     data =3D self._sock.recv(self._rbufsize)
> error: [Errno 104] Connection reset by peer
>=20
> ----------------------------------------------------------------------


I'm not sure whether the problem is really from
x-debug-block-dirty-bitmap-sha256, or from the self.vm_a.shutdown() on
line 116 in iotest 169...  Or maybe from something else entirely?


A slightly different failure pattern is this:

> test_do_test_migration_resume_source_not_persistent__migbitmap (__main_=
_.TestDirtyBitmapMigration) ... DEBUG:QMP:>>> {'execute': 'qmp_capabiliti=
es'}
> DEBUG:QMP:<<< {u'return': {}}
> DEBUG:QMP:>>> {'execute': 'migrate-set-capabilities', 'arguments': {'ca=
pabilities': [{'capability': 'events', 'state': True}, {'capability': 'di=
rty-bitmaps', 'state': True}]}}
> DEBUG:QMP:<<< {u'return': {}}
> DEBUG:QMP:>>> {'execute': 'block-dirty-bitmap-add', 'arguments': {'node=
': 'drive0', 'name': 'bitmap0', 'granularity': 512}}
> DEBUG:QMP:<<< {u'return': {}}
> DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'comma=
nd-line': 'qemu-io drive0 "write 0 65536"'}}
> DEBUG:QMP:<<< {u'return': u''}
> DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'comma=
nd-line': 'qemu-io drive0 "write 983040 65536"'}}
> DEBUG:QMP:<<< {u'return': u''}
> DEBUG:QMP:>>> {'execute': 'human-monitor-command', 'arguments': {'comma=
nd-line': 'qemu-io drive0 "write 655873 4096"'}}
> DEBUG:QMP:<<< {u'return': u''}
> DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'argumen=
ts': {'node': 'drive0', 'name': 'bitmap0'}}
> DEBUG:QMP:<<< {u'return': {u'sha256': u'01d2ebedcb8f549a2547dbf8e231c41=
0e3e747a9479e98909fc936e0035cf8b1'}}
> DEBUG:QMP:>>> {'execute': 'migrate', 'arguments': {'uri': 'exec: cat > =
/tmp/t0/test-qcow2-file/mig_file'}}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': =
466831}, u'data': {u'status': u'setup'}, u'event': u'MIGRATION'}
> DEBUG:QMP:<<< {u'return': {}}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': =
472171}, u'data': {u'pass': 1}, u'event': u'MIGRATION_PASS'}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': =
472233}, u'data': {u'status': u'active'}, u'event': u'MIGRATION'}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': =
571246}, u'data': {u'pass': 2}, u'event': u'MIGRATION_PASS'}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': =
571665}, u'event': u'STOP'}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': =
571934}, u'data': {u'pass': 3}, u'event': u'MIGRATION_PASS'}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': =
574302}, u'data': {u'status': u'completed'}, u'event': u'MIGRATION'}
> DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'argumen=
ts': {'node': 'drive0', 'name': 'bitmap0'}}
> DEBUG:QMP:<<< {u'return': {u'sha256': u'01d2ebedcb8f549a2547dbf8e231c41=
0e3e747a9479e98909fc936e0035cf8b1'}}
> DEBUG:QMP:>>> {'execute': 'cont'}
> DEBUG:QMP:<<< {u'timestamp': {u'seconds': 1548263493, u'microseconds': =
576305}, u'event': u'RESUME'}
> DEBUG:QMP:<<< {u'return': {}}
> DEBUG:QMP:>>> {'execute': 'x-debug-block-dirty-bitmap-sha256', 'argumen=
ts': {'node': 'drive0', 'name': 'bitmap0'}}
> DEBUG:QMP:<<< {u'return': {u'sha256': u'01d2ebedcb8f549a2547dbf8e231c41=
0e3e747a9479e98909fc936e0035cf8b1'}}
> DEBUG:QMP:>>> {'execute': 'quit'}
> WARNING:qemu:qemu received signal 6: build/tests/qemu-iotests/../../x86=
_64-softmmu/qemu-system-x86_64 -chardev socket,id=3Dmon,path=3D/tmp/t0/te=
st-qcow2-file/tmpG2ZjZB/qemua-4834-monitor.sock -mon chardev=3Dmon,mode=3D=
control -display none -vga none -qtest unix:path=3D/tmp/t0/test-qcow2-fil=
e/qemua-4834-qtest.sock -machine accel=3Dqtest -nodefaults -machine accel=
=3Dqtest -drive if=3Dvirtio,id=3Ddrive0,file=3D/tmp/t0/test-qcow2-file/di=
sk_a,format=3Dqcow2,cache=3Dwritethrough
> WARNING:qemu:qemu received signal 6: build/tests/qemu-iotests/../../x86=
_64-softmmu/qemu-system-x86_64 -chardev socket,id=3Dmon,path=3D/tmp/t0/te=
st-qcow2-file/tmpG2ZjZB/qemua-4834-monitor.sock -mon chardev=3Dmon,mode=3D=
control -display none -vga none -qtest unix:path=3D/tmp/t0/test-qcow2-fil=
e/qemua-4834-qtest.sock -machine accel=3Dqtest -nodefaults -machine accel=
=3Dqtest -drive if=3Dvirtio,id=3Ddrive0,file=3D/tmp/t0/test-qcow2-file/di=
sk_a,format=3Dqcow2,cache=3Dwritethrough
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> FAIL: test_do_test_migration_resume_source_not_persistent__migbitmap (_=
_main__.TestDirtyBitmapMigration)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "169", line 206, in <lambda>
>     setattr(klass, 'test_' + method + name, lambda self: mc(self))
>   File "169", line 125, in do_test_migration_resume_source
>     self.assertEqual(log, '')
> AssertionError: "qemu-system-x86_64: invalid runstate transition: 'runn=
ing' -> 'postmigrate'\n" !=3D ''

So here looks more like the shutdown is the problem.

Max


--GvHAlrFtRX5870d7oaHZOG3DqXHuWX5sR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIoWIACgkQ9AfbAGHV
z0CKlAf9Faha4FQBxEVVoEscWqiH37nTtNXpCA5YbUULpGA6wGniL3JC6f4Pb0az
aL0PvMLCAHZc3DXGoC5TCawsIvmBgW6h2siS+AEUhrs5Dzu3U6cgrqvQHTPA8RIC
sDYPca2XhfM5wohTGUZpUbmuyaIWVjh3261bXyJ2YZdyZSBOX/GUn302mF6bJglp
y6+nO0sNK+GHDhAGkWxwNx5p72z2KkvsZgM5LXrchNqelk7QSnrFJx3smf9qAlgc
LBbxN9MtJt40MdTxk0jDW20b8W0p4Z6O8nYL5Q53WHBlIiIrm0FKQ6LBm2NNGJRn
fP1HPDaYfSb/CjFvJbBNh0o5VQlulg==
=wXE1
-----END PGP SIGNATURE-----

--GvHAlrFtRX5870d7oaHZOG3DqXHuWX5sR--
