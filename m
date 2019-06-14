Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A96BC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38F821744
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38F821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnuS-0003N3-0q
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48290)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbnpY-0007gF-QL
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbnpW-000429-EZ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:09:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46619)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbnpW-00040Z-4P
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:09:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so2876291wrw.13
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 08:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=Dy79Z/jpboZvtSSP6vjiGLmZtl7QxeoIuU0hAv4MCsA=;
 b=MCmSKUqNeLqyoKY2vwv9lA7aeoOlcOfD8PB6JKEXULnG5fSVkztGA/rZwFJC1Y4bAQ
 4677rIxswbAUGpobrPNuQ7mzBVR+mg77H18KCmHpq42chFCLOQDpQLZdGEf69hyqYk3+
 QCjl2Tko/khz2Jk3LS1VRReuM5g3pCrEfMiTsmNqOpoHr8EmaieP17tVuIo+HSRDLPXX
 vmnkQDxIOztAQYaHW/nxEWMISLv2D9nkhpeTtHQiKDnjIyCl86MyaAXceD9E2/Gh59ni
 uW5vSV3reH0gm/I52NNYDnGuB+fXqaQXlZF8md2pDQQfKSYYV9UEZY1x/joZsThSSHYJ
 O8ZA==
X-Gm-Message-State: APjAAAWBRlsijCC4S5EstkyKYmj/eDTfH0Un3H8p1WiXIbAS/R0P1PsP
 wvB5RY5Z3NiA9F1KDzWYxB/E7Q==
X-Google-Smtp-Source: APXvYqyOgRpzkuNmNwRyabXaLxSiZvutqfrcJC/1KcFtgLcmi5k0Ols2bYnj0C7O4Hm0gt+P+8OaiQ==
X-Received: by 2002:adf:afd5:: with SMTP id y21mr63470717wrd.12.1560524964706; 
 Fri, 14 Jun 2019 08:09:24 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y6sm2569922wrp.12.2019.06.14.08.09.23
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 08:09:23 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>, Pino Toscano <ptoscano@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190613132000.2146-1-ptoscano@redhat.com>
 <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
 <69064867-56ec-be41-a59e-30cb085247ea@redhat.com>
 <04ebf0f8-25eb-57ba-4b09-def017726714@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5d399abc-3ef2-5eeb-9580-36a48d827c30@redhat.com>
Date: Fri, 14 Jun 2019 17:09:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <04ebf0f8-25eb-57ba-4b09-def017726714@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HzFCtY7FxM4fXlTFBR5I0FQC1ywuS6imG"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v9] ssh: switch from libssh2 to libssh
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, alex.bennee@linaro.org, rjones@redhat.com,
 sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HzFCtY7FxM4fXlTFBR5I0FQC1ywuS6imG
Content-Type: multipart/mixed; boundary="EXmzY9xRSLQipx0sEoaHDkWDnhUSBzvt5";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Pino Toscano <ptoscano@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: rjones@redhat.com, kwolf@redhat.com, alex.bennee@linaro.org,
 fam@euphon.net, sw@weilnetz.de
Message-ID: <5d399abc-3ef2-5eeb-9580-36a48d827c30@redhat.com>
Subject: Re: [PATCH v9] ssh: switch from libssh2 to libssh
References: <20190613132000.2146-1-ptoscano@redhat.com>
 <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
 <69064867-56ec-be41-a59e-30cb085247ea@redhat.com>
 <04ebf0f8-25eb-57ba-4b09-def017726714@redhat.com>
In-Reply-To: <04ebf0f8-25eb-57ba-4b09-def017726714@redhat.com>

--EXmzY9xRSLQipx0sEoaHDkWDnhUSBzvt5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/14/19 4:30 PM, Max Reitz wrote:
> On 14.06.19 16:26, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 6/13/19 9:31 PM, Max Reitz wrote:
>>> On 13.06.19 15:20, Pino Toscano wrote:
>>>> Rewrite the implementation of the ssh block driver to use libssh ins=
tead
>>>> of libssh2.  The libssh library has various advantages over libssh2:=

>>>> - easier API for authentication (for example for using ssh-agent)
>>>> - easier API for known_hosts handling
>>>> - supports newer types of keys in known_hosts
>>>>
>>>> Use APIs/features available in libssh 0.8 conditionally, to support
>>>> older versions (which are not recommended though).
>>>>
>>>> Adjust the tests according to the different error message, and to th=
e
>>>> newer host keys (ed25519) that are used by default with OpenSSH >=3D=
 6.7
>>>> and libssh >=3D 0.7.0.
>>>>
>>>> Adjust the various Docker/Travis scripts to use libssh when availabl=
e
>>>> instead of libssh2. The mingw/mxe testing is dropped for now, as the=
re
>>>> are no packages for it.
>>>>
>>>> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
>>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>
>>> Can confirm that this runs much faster than the last version I tested=
=2E
>>> 197 and 215 are still whacky (like 100 s instead of 50), but that=E2=80=
=99s fine
>>> with me. :-)
>>>
>>>> Changes from v8:
>>>> - use a newer key type in iotest 207
>>>> - improve the commit message
>>>>
>>>> Changes from v7:
>>>> - #if HAVE_LIBSSH_0_8 -> #ifdef HAVE_LIBSSH_0_8
>>>> - ptrdiff_t -> size_t
>>>>
>>>> Changes from v6:
>>>> - fixed few checkpatch style issues
>>>> - detect libssh 0.8 via symbol detection
>>>> - adjust travis/docker test material
>>>> - remove dead "default" case in a switch
>>>> - use variables for storing MIN() results
>>>> - adapt a documentation bit
>>>>
>>>> Changes from v5:
>>>> - adapt to newer tracing APIs
>>>> - disable ssh compression (mimic what libssh2 does by default)
>>>> - use build time checks for libssh 0.8, and use newer APIs directly
>>>>
>>>> Changes from v4:
>>>> - fix wrong usages of error_setg/session_error_setg/sftp_error_setg
>>>> - fix few return code checks
>>>> - remove now-unused parameters in few internal functions
>>>> - allow authentication with "none" method
>>>> - switch to unsigned int for the port number
>>>> - enable TCP_NODELAY on the socket
>>>> - fix one reference error message in iotest 207
>>>>
>>>> Changes from v3:
>>>> - fix socket cleanup in connect_to_ssh()
>>>> - add comments about the socket cleanup
>>>> - improve the error reporting (closer to what was with libssh2)
>>>> - improve EOF detection on sftp_read()
>>>>
>>>> Changes from v2:
>>>> - used again an own fd
>>>> - fixed co_yield() implementation
>>>>
>>>> Changes from v1:
>>>> - fixed jumbo packets writing
>>>> - fixed missing 'err' assignment
>>>> - fixed commit message
>>>>
>>>>  .travis.yml                                   |   4 +-
>>>>  block/Makefile.objs                           |   6 +-
>>>>  block/ssh.c                                   | 622 +++++++++------=
---
>>>>  block/trace-events                            |  14 +-
>>>>  configure                                     |  65 +-
>>>>  docs/qemu-block-drivers.texi                  |   2 +-
>>>>  .../dockerfiles/debian-win32-cross.docker     |   1 -
>>>>  .../dockerfiles/debian-win64-cross.docker     |   1 -
>>>>  tests/docker/dockerfiles/fedora.docker        |   4 +-
>>>>  tests/docker/dockerfiles/ubuntu.docker        |   2 +-
>>>>  tests/docker/dockerfiles/ubuntu1804.docker    |   2 +-
>>>>  tests/qemu-iotests/207                        |   4 +-
>>>>  tests/qemu-iotests/207.out                    |   2 +-
>>>>  13 files changed, 376 insertions(+), 353 deletions(-)
>>>
>>> Surprisingly little has changed since v4.  Good, good, that makes my
>>> reviewing job much easier because I can thus rely on past me. :-)
>>>
>>>> diff --git a/block/ssh.c b/block/ssh.c
>>>> index 6da7b9cbfe..fb458d4548 100644
>>>> --- a/block/ssh.c
>>>> +++ b/block/ssh.c
>>>
>>> [...]
>>>
>>>> @@ -282,82 +274,85 @@ static void ssh_parse_filename(const char *fil=
ename, QDict *options,
>>>>      parse_uri(filename, options, errp);
>>>>  }
>>>> =20
>>>> -static int check_host_key_knownhosts(BDRVSSHState *s,
>>>> -                                     const char *host, int port, Er=
ror **errp)
>>>> +static int check_host_key_knownhosts(BDRVSSHState *s, Error **errp)=

>>>>  {
>>>
>>> [...]
>>>
>>>> -    switch (r) {
>>>> -    case LIBSSH2_KNOWNHOST_CHECK_MATCH:
>>>> +    switch (state) {
>>>> +    case SSH_KNOWN_HOSTS_OK:
>>>>          /* OK */
>>>> -        trace_ssh_check_host_key_knownhosts(found->key);
>>>> +        trace_ssh_check_host_key_knownhosts();
>>>>          break;
>>>> -    case LIBSSH2_KNOWNHOST_CHECK_MISMATCH:
>>>> +    case SSH_KNOWN_HOSTS_CHANGED:
>>>>          ret =3D -EINVAL;
>>>> -        session_error_setg(errp, s,
>>>> -                      "host key does not match the one in known_hos=
ts"
>>>> -                      " (found key %s)", found->key);
>>>> +        error_setg(errp, "host key does not match the one in known_=
hosts");
>>>
>>> So what about the possible attack warning that the specification
>>> technically requires us to print? O:-)
>>>
>>>>          goto out;
>>>> -    case LIBSSH2_KNOWNHOST_CHECK_NOTFOUND:
>>>> +    case SSH_KNOWN_HOSTS_OTHER:
>>>>          ret =3D -EINVAL;
>>>> -        session_error_setg(errp, s, "no host key was found in known=
_hosts");
>>>> +        error_setg(errp,
>>>> +                   "host key for this server not found, another typ=
e exists");
>>>>          goto out;
>>>> -    case LIBSSH2_KNOWNHOST_CHECK_FAILURE:
>>>> +    case SSH_KNOWN_HOSTS_UNKNOWN:
>>>>          ret =3D -EINVAL;
>>>> -        session_error_setg(errp, s,
>>>> -                      "failure matching the host key with known_hos=
ts");
>>>> +        error_setg(errp, "no host key was found in known_hosts");
>>>> +        goto out;
>>>> +    case SSH_KNOWN_HOSTS_NOT_FOUND:
>>>> +        ret =3D -ENOENT;
>>>> +        error_setg(errp, "known_hosts file not found");
>>>> +        goto out;
>>>> +    case SSH_KNOWN_HOSTS_ERROR:
>>>> +        ret =3D -EINVAL;
>>>> +        error_setg(errp, "error while checking the host");
>>>>          goto out;
>>>>      default:
>>>>          ret =3D -EINVAL;
>>>> -        session_error_setg(errp, s, "unknown error matching the hos=
t key"
>>>> -                      " with known_hosts (%d)", r);
>>>> +        error_setg(errp, "error while checking for known server");
>>>>          goto out;
>>>>      }
>>>> +#else /* !HAVE_LIBSSH_0_8 */
>>>> +    int state;
>>>> +
>>>> +    state =3D ssh_is_server_known(s->session);
>>>> +    trace_ssh_server_status(state);
>>>> +
>>>> +    switch (state) {
>>>> +    case SSH_SERVER_KNOWN_OK:
>>>> +        /* OK */
>>>> +        trace_ssh_check_host_key_knownhosts();
>>>> +        break;
>>>> +    case SSH_SERVER_KNOWN_CHANGED:
>>>> +        ret =3D -EINVAL;
>>>> +        error_setg(errp, "host key does not match the one in known_=
hosts");
>>>> +        goto out;
>>>> +    case SSH_SERVER_FOUND_OTHER:
>>>> +        ret =3D -EINVAL;
>>>> +        error_setg(errp,
>>>> +                   "host key for this server not found, another typ=
e exists");
>>>> +        goto out;
>>>> +    case SSH_SERVER_FILE_NOT_FOUND:
>>>> +        ret =3D -ENOENT;
>>>> +        error_setg(errp, "known_hosts file not found");
>>>> +        goto out;
>>>> +    case SSH_SERVER_NOT_KNOWN:
>>>> +        ret =3D -EINVAL;
>>>> +        error_setg(errp, "no host key was found in known_hosts");
>>>> +        goto out;
>>>> +    case SSH_SERVER_ERROR:
>>>> +        ret =3D -EINVAL;
>>>> +        error_setg(errp, "server error");
>>>> +        goto out;
>>>
>>> No default here?
>>
>> I explicitly suggested Pino to not use default here, since
>> ssh_server_known_e is a finite enum. If upstream libssh adds more
>> errors, and a distrib packages a new version, we'll get a build error.=

>> It looks quicker for us to react than adding a abort() here and wait a=
n
>> user to complain. But this is a personal preference, I won't object if=

>> you prefer we use a default here.
>=20
> Well, OK, but this is the pre-0.8 code path,  "state" is an integer her=
e.

Aha! Good catch :) On v6 review I asked the opposite, no default for
0.0.8 enum, and default for pre-0.8:

https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg02466.html

Pino: can you fix this please?

>>>> +    }
>>>> +#endif /* !HAVE_LIBSSH_0_8 */
>=20
> [...]
>=20
>>>> diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
>>>> index b3816136f7..774eb5f2a9 100755
>>>> --- a/tests/qemu-iotests/207
>>>> +++ b/tests/qemu-iotests/207
>>>
>>> [...]
>>>
>>>> @@ -149,7 +149,7 @@ with iotests.FilePath('t.img') as disk_path, \
>>>>      iotests.img_info_log(remote_path)
>>>> =20
>>>>      sha1_key =3D subprocess.check_output(
>>>> -        'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" =
| ' +
>>>> +        'ssh-keyscan -t ssh-ed25519 127.0.0.1 2>/dev/null | grep -v=
 "\\^#" | ' +
>>>>          'cut -d" " -f3 | base64 -d | sha1sum -b | cut -d" " -f1',
>>>>          shell=3DTrue).rstrip().decode('ascii')
>>>
>>> Hm.  This is a pain.
>>>
>>> I suppose the best would be to drop the "-t" altogether and then chec=
k
>>> whether any of the entries ssh-keyscan reports matches.
>>
>> This was my first approach, but then the 207.out file doesn't match.
>> I don't know enough of iotests fu to help here :(
>=20
> I=E2=80=99ll see what I can do.

Awesome, thanks!


--EXmzY9xRSLQipx0sEoaHDkWDnhUSBzvt5--

--HzFCtY7FxM4fXlTFBR5I0FQC1ywuS6imG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAl0DuKIACgkQoqP9bt6t
wN6V1w//QoJkyIku81z0omWVLn6+/9yqmQpEH8PfrRAqimz5tFEb3/Hf7AKaQEZI
DpRBFiGle60sisGPkXAQd4jrsal7LcjhEZZjlbZMQF8cv5McAFVY4/GTyYndRTiJ
oPsbmKYEwx0qnmQAA8N4ulidA7f/yW1N/afeJJkUiJ2eLVNaTjgggSm4+D+k6su+
HMGPui+zy4kcQ0Wm4mVAjtai2dj7oUxiytaSYXOj/oU/i68tis4GJbeX6bNx5M46
/wcLWKLZGYkFKXUvyDV2E/tGNFwoRUNScJzZNq+XmtYl2tYli0+5D/kyumoW+TdS
oWerjzNZZNlBPM/QTrzh5WPhEw9aBmxVcOvZHKU1mirNIyrWhhv1XC3T+PhXnGn6
z5Jb9kCSm+icDxA6bpIVc0ObJ571JzaUnAOEl/itKO8c+s3iYkhG0kg3O2FIjL3z
hjxmeuKrksLUM4w87eL/qEtjb7JMT1lWj/neLdDKIqEG/TeRRTwiiDu23h7adrBz
paVA6htBvrNs+eLSQIr2M3ERAGNMAhMHS2dTSNV47rLP6yx6vCXXDxgfihro9QNl
hkOcbd2WxLEPRfhZnVeiAMLpjA3+nH9zMMf/z+gaLWgS9ThDpfaZhJYFWinqHgdK
amtx1z+Xsc0ByiFO5ib7D0HOpAhSD8mdbg5usx64rE2i/5h10sI=
=Gxf9
-----END PGP SIGNATURE-----

--HzFCtY7FxM4fXlTFBR5I0FQC1ywuS6imG--

