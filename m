Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9B9C31E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473802173C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473802173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbneF-0007QB-1B
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32815)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbnA9-0001M8-Li
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbnA7-0006di-IC
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:26:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbnA7-0006aE-8p
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:26:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so2540112wmj.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 07:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VhRfVCR3BjK+hWz7jD4jIaBCLwIPLjS2CTaFDutvqro=;
 b=h9ZywiPFhcz6SSBoIsv1v5kCcLzDkQWK7TefZ+A/PE0xburz7cJGL1SiL9+wcShtM3
 Ok1mynEbYn2bvBmfY++HrsIGJb0g0ZRHh9Tmk4SplUQaRjq88iBzzbSEhEMAmpIpER5c
 VgmCLQ7AFdLx+5/+pvaY6lBwBGaizs/c420kMjJg+6lmg8oz2/hNPqWDMLFwPDWFSQQ2
 iZLDG9JOjTzKD+Zdhsm5KOVYg4WquEZ9amAF575A6ye8XO4VLAdZgd8/mTbFalRLIj/Z
 idobQrVxYcHAX8y2VTT/RHLOqlPTuzthy2am4zihWe/VCBtKPGQusrEfYb0YKxpMoAev
 Q8Fg==
X-Gm-Message-State: APjAAAUpjUMZiV+yRJhGjwSF1mXzY11b0atu/Cat46zkPukbfOuSi5K0
 3LAC2+puKYRfH1OU8lhPBUadLA==
X-Google-Smtp-Source: APXvYqzHRBr414iByiyFhoeZzTqjo4+91lh/pZej1ZJ95zIHE7ZlQpbKRDRY6uPrekm0vYRAvdZUXA==
X-Received: by 2002:a1c:9e92:: with SMTP id h140mr7841732wme.82.1560522396217; 
 Fri, 14 Jun 2019 07:26:36 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id u5sm4137649wmc.32.2019.06.14.07.26.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 07:26:35 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>, Pino Toscano <ptoscano@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190613132000.2146-1-ptoscano@redhat.com>
 <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <69064867-56ec-be41-a59e-30cb085247ea@redhat.com>
Date: Fri, 14 Jun 2019 16:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
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

On 6/13/19 9:31 PM, Max Reitz wrote:
> On 13.06.19 15:20, Pino Toscano wrote:
>> Rewrite the implementation of the ssh block driver to use libssh instead
>> of libssh2.  The libssh library has various advantages over libssh2:
>> - easier API for authentication (for example for using ssh-agent)
>> - easier API for known_hosts handling
>> - supports newer types of keys in known_hosts
>>
>> Use APIs/features available in libssh 0.8 conditionally, to support
>> older versions (which are not recommended though).
>>
>> Adjust the tests according to the different error message, and to the
>> newer host keys (ed25519) that are used by default with OpenSSH >= 6.7
>> and libssh >= 0.7.0.
>>
>> Adjust the various Docker/Travis scripts to use libssh when available
>> instead of libssh2. The mingw/mxe testing is dropped for now, as there
>> are no packages for it.
>>
>> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Acked-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
> 
> Can confirm that this runs much faster than the last version I tested.
> 197 and 215 are still whacky (like 100 s instead of 50), but that’s fine
> with me. :-)
> 
>> Changes from v8:
>> - use a newer key type in iotest 207
>> - improve the commit message
>>
>> Changes from v7:
>> - #if HAVE_LIBSSH_0_8 -> #ifdef HAVE_LIBSSH_0_8
>> - ptrdiff_t -> size_t
>>
>> Changes from v6:
>> - fixed few checkpatch style issues
>> - detect libssh 0.8 via symbol detection
>> - adjust travis/docker test material
>> - remove dead "default" case in a switch
>> - use variables for storing MIN() results
>> - adapt a documentation bit
>>
>> Changes from v5:
>> - adapt to newer tracing APIs
>> - disable ssh compression (mimic what libssh2 does by default)
>> - use build time checks for libssh 0.8, and use newer APIs directly
>>
>> Changes from v4:
>> - fix wrong usages of error_setg/session_error_setg/sftp_error_setg
>> - fix few return code checks
>> - remove now-unused parameters in few internal functions
>> - allow authentication with "none" method
>> - switch to unsigned int for the port number
>> - enable TCP_NODELAY on the socket
>> - fix one reference error message in iotest 207
>>
>> Changes from v3:
>> - fix socket cleanup in connect_to_ssh()
>> - add comments about the socket cleanup
>> - improve the error reporting (closer to what was with libssh2)
>> - improve EOF detection on sftp_read()
>>
>> Changes from v2:
>> - used again an own fd
>> - fixed co_yield() implementation
>>
>> Changes from v1:
>> - fixed jumbo packets writing
>> - fixed missing 'err' assignment
>> - fixed commit message
>>
>>  .travis.yml                                   |   4 +-
>>  block/Makefile.objs                           |   6 +-
>>  block/ssh.c                                   | 622 +++++++++---------
>>  block/trace-events                            |  14 +-
>>  configure                                     |  65 +-
>>  docs/qemu-block-drivers.texi                  |   2 +-
>>  .../dockerfiles/debian-win32-cross.docker     |   1 -
>>  .../dockerfiles/debian-win64-cross.docker     |   1 -
>>  tests/docker/dockerfiles/fedora.docker        |   4 +-
>>  tests/docker/dockerfiles/ubuntu.docker        |   2 +-
>>  tests/docker/dockerfiles/ubuntu1804.docker    |   2 +-
>>  tests/qemu-iotests/207                        |   4 +-
>>  tests/qemu-iotests/207.out                    |   2 +-
>>  13 files changed, 376 insertions(+), 353 deletions(-)
> 
> Surprisingly little has changed since v4.  Good, good, that makes my
> reviewing job much easier because I can thus rely on past me. :-)
> 
>> diff --git a/block/ssh.c b/block/ssh.c
>> index 6da7b9cbfe..fb458d4548 100644
>> --- a/block/ssh.c
>> +++ b/block/ssh.c
> 
> [...]
> 
>> @@ -282,82 +274,85 @@ static void ssh_parse_filename(const char *filename, QDict *options,
>>      parse_uri(filename, options, errp);
>>  }
>>  
>> -static int check_host_key_knownhosts(BDRVSSHState *s,
>> -                                     const char *host, int port, Error **errp)
>> +static int check_host_key_knownhosts(BDRVSSHState *s, Error **errp)
>>  {
> 
> [...]
> 
>> -    switch (r) {
>> -    case LIBSSH2_KNOWNHOST_CHECK_MATCH:
>> +    switch (state) {
>> +    case SSH_KNOWN_HOSTS_OK:
>>          /* OK */
>> -        trace_ssh_check_host_key_knownhosts(found->key);
>> +        trace_ssh_check_host_key_knownhosts();
>>          break;
>> -    case LIBSSH2_KNOWNHOST_CHECK_MISMATCH:
>> +    case SSH_KNOWN_HOSTS_CHANGED:
>>          ret = -EINVAL;
>> -        session_error_setg(errp, s,
>> -                      "host key does not match the one in known_hosts"
>> -                      " (found key %s)", found->key);
>> +        error_setg(errp, "host key does not match the one in known_hosts");
> 
> So what about the possible attack warning that the specification
> technically requires us to print? O:-)
> 
>>          goto out;
>> -    case LIBSSH2_KNOWNHOST_CHECK_NOTFOUND:
>> +    case SSH_KNOWN_HOSTS_OTHER:
>>          ret = -EINVAL;
>> -        session_error_setg(errp, s, "no host key was found in known_hosts");
>> +        error_setg(errp,
>> +                   "host key for this server not found, another type exists");
>>          goto out;
>> -    case LIBSSH2_KNOWNHOST_CHECK_FAILURE:
>> +    case SSH_KNOWN_HOSTS_UNKNOWN:
>>          ret = -EINVAL;
>> -        session_error_setg(errp, s,
>> -                      "failure matching the host key with known_hosts");
>> +        error_setg(errp, "no host key was found in known_hosts");
>> +        goto out;
>> +    case SSH_KNOWN_HOSTS_NOT_FOUND:
>> +        ret = -ENOENT;
>> +        error_setg(errp, "known_hosts file not found");
>> +        goto out;
>> +    case SSH_KNOWN_HOSTS_ERROR:
>> +        ret = -EINVAL;
>> +        error_setg(errp, "error while checking the host");
>>          goto out;
>>      default:
>>          ret = -EINVAL;
>> -        session_error_setg(errp, s, "unknown error matching the host key"
>> -                      " with known_hosts (%d)", r);
>> +        error_setg(errp, "error while checking for known server");
>>          goto out;
>>      }
>> +#else /* !HAVE_LIBSSH_0_8 */
>> +    int state;
>> +
>> +    state = ssh_is_server_known(s->session);
>> +    trace_ssh_server_status(state);
>> +
>> +    switch (state) {
>> +    case SSH_SERVER_KNOWN_OK:
>> +        /* OK */
>> +        trace_ssh_check_host_key_knownhosts();
>> +        break;
>> +    case SSH_SERVER_KNOWN_CHANGED:
>> +        ret = -EINVAL;
>> +        error_setg(errp, "host key does not match the one in known_hosts");
>> +        goto out;
>> +    case SSH_SERVER_FOUND_OTHER:
>> +        ret = -EINVAL;
>> +        error_setg(errp,
>> +                   "host key for this server not found, another type exists");
>> +        goto out;
>> +    case SSH_SERVER_FILE_NOT_FOUND:
>> +        ret = -ENOENT;
>> +        error_setg(errp, "known_hosts file not found");
>> +        goto out;
>> +    case SSH_SERVER_NOT_KNOWN:
>> +        ret = -EINVAL;
>> +        error_setg(errp, "no host key was found in known_hosts");
>> +        goto out;
>> +    case SSH_SERVER_ERROR:
>> +        ret = -EINVAL;
>> +        error_setg(errp, "server error");
>> +        goto out;
> 
> No default here?

I explicitly suggested Pino to not use default here, since
ssh_server_known_e is a finite enum. If upstream libssh adds more
errors, and a distrib packages a new version, we'll get a build error.
It looks quicker for us to react than adding a abort() here and wait an
user to complain. But this is a personal preference, I won't object if
you prefer we use a default here.

> 
>> +    }
>> +#endif /* !HAVE_LIBSSH_0_8 */
>>  
>>      /* known_hosts checking successful. */
>>      ret = 0;
>>  
>>   out:
>> -    if (knh != NULL) {
>> -        libssh2_knownhost_free(knh);
>> -    }
>> -    g_free(knh_file);
>>      return ret;
>>  }
> 
> [...]
> 
>> @@ -657,71 +644,147 @@ static int connect_to_ssh(BDRVSSHState *s, BlockdevOptionsSsh *opts,
> 
> [...]
> 
>> +    /*
>> +     * Try to disable the Nagle algorithm on TCP sockets to reduce latency,
>> +     * but do not fail if it cannot be disabled.
>> +     */
>> +    r = socket_set_nodelay(new_sock);
>> +    if (r < 0) {
>> +        warn_report("setting NODELAY for the ssh server %s failed: %m",
> 
> TIL about %m.
> 
>> +                    s->inet->host);
>> +    }
>> +
> 
> [...]
> 
>> @@ -775,16 +845,13 @@ static int ssh_file_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
>>      }
>>  
>>      /* Go non-blocking. */
>> -    libssh2_session_set_blocking(s->session, 0);
>> +    ssh_set_blocking(s->session, 0);
>>  
>>      qapi_free_BlockdevOptionsSsh(opts);
>>  
>>      return 0;
>>  
>>   err:
>> -    if (s->sock >= 0) {
>> -        close(s->sock);
>> -    }
>>      s->sock = -1;
> 
> Shouldn’t connect_to_ssh() set this to -1 after closing the session?
> 
>>  
>>      qapi_free_BlockdevOptionsSsh(opts);
> 
> [...]
> 
>> diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
>> index b3816136f7..774eb5f2a9 100755
>> --- a/tests/qemu-iotests/207
>> +++ b/tests/qemu-iotests/207
> 
> [...]
> 
>> @@ -149,7 +149,7 @@ with iotests.FilePath('t.img') as disk_path, \
>>      iotests.img_info_log(remote_path)
>>  
>>      sha1_key = subprocess.check_output(
>> -        'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | ' +
>> +        'ssh-keyscan -t ssh-ed25519 127.0.0.1 2>/dev/null | grep -v "\\^#" | ' +
>>          'cut -d" " -f3 | base64 -d | sha1sum -b | cut -d" " -f1',
>>          shell=True).rstrip().decode('ascii')
> 
> Hm.  This is a pain.
> 
> I suppose the best would be to drop the "-t" altogether and then check
> whether any of the entries ssh-keyscan reports matches.

This was my first approach, but then the 207.out file doesn't match.
I don't know enough of iotests fu to help here :(

Regards,

Phil.

