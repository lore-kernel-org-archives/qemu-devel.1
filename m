Received: from eggs.gnu.org ([2001:4830:134:3::10]:35174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ezOxf-00076v-TC
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ezOxa-0005v4-Di
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:50:35 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:43356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ezOxa-0005uT-9o
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 11:50:30 -0400
Received: by mail-qt0-f170.google.com with SMTP id s48so12998217qtb.10
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 08:50:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323153537.GS32362@xz-mi>
References: <20180323103239.32414-1-marcandre.lureau@redhat.com>
	<20180323153537.GS32362@xz-mi>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 23 Mar 2018 16:50:28 +0100
Message-ID: <CAMxuvax=SPeOui3mGcmK8HAo7EqDbpUSZ8Fq3mVHCrLztmBCLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: fix expected qmp_capabilities
 error description regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Blake, Eric" <eblake@redhat.com>

Hi

On Fri, Mar 23, 2018 at 4:35 PM, Peter Xu <peterx@redhat.com> wrote:
> On Fri, Mar 23, 2018 at 11:32:39AM +0100, Marc-Andr=C3=A9 Lureau wrote:
>> Fix regression introduced in commit cf869d53172920536a14180a83292b240e9d=
0545:
>>
>> Before:
>> {"execute":"foo"}
>> {"error": {"class": "CommandNotFound", "desc": "Expecting capabilities n=
egotiation with 'qmp_capabilities'"}}
>>
>> After:
>> {"execute":"foo"}
>> {"error": {"class": "CommandNotFound", "desc": "The command foo has not =
been found"}}
>>
>> Because qmp_cmd_oob_check() happens before
>> monitor_qmp_dispatch_one(). Move the error manipulation code to
>> monitor_qmp_respond() instead.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  monitor.c | 25 ++++++++++++-------------
>>  1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index 6ccd2fc089..d57bbbb134 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -3997,6 +3997,18 @@ static void monitor_qmp_respond(Monitor *mon, QOb=
ject *rsp,
>>              qdict_put_obj(qobject_to(QDict, rsp), "id", id);
>>          }
>>
>> +        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
>> +            qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error");
>> +            if (qdict
>> +                && !g_strcmp0(qdict_get_try_str(qdict, "class"),
>> +                          QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FO=
UND))) {
>> +                /* Provide a more useful error message */
>> +                qdict_del(qdict, "desc");
>> +                qdict_put_str(qdict, "desc", "Expecting capabilities"
>> +                              " negotiation with 'qmp_capabilities'");
>> +            }
>> +        }
>> +
>
> If we are going to remove below chunk, how about do it in prettier
> way instead of hacking around the error again?  Like:
>
> diff --git a/monitor.c b/monitor.c
> index 77f4c41cfa..849fa23bf9 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1203,8 +1203,14 @@ static bool qmp_cmd_oob_check(Monitor *mon, QDict =
*req, Error **errp)
>
>      cmd =3D qmp_find_command(mon->qmp.commands, command);
>      if (!cmd) {
> -        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
> -                  "The command %s has not been found", command);
> +        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
> +            error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
> +                      "Expecting capabilities negotiation "
> +                      "with 'qmp_capabilities'");
> +        } else {
> +            error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
> +                      "The command %s has not been found", command);
> +        }
>          return false;
>      }
>
> What do you think?
>

Works for me (fwiw, I'll probably need the replace "hack" again,
because in the RFC series I am about to send, the code is factored out
/ generalized in qmp-dispatch), but that works in the meantime, please
send a patch.

> Thanks,
>
>>          monitor_json_emitter(mon, rsp);
>>      }
>>
>> @@ -4028,7 +4040,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *r=
eq_obj)
>>  {
>>      Monitor *mon, *old_mon;
>>      QObject *req, *rsp =3D NULL, *id;
>> -    QDict *qdict =3D NULL;
>>      bool need_resume;
>>
>>      req =3D req_obj->req;
>> @@ -4051,18 +4062,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *=
req_obj)
>>
>>      cur_mon =3D old_mon;
>>
>> -    if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
>> -        qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error");
>> -        if (qdict
>> -            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
>> -                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND)))=
 {
>> -            /* Provide a more useful error message */
>> -            qdict_del(qdict, "desc");
>> -            qdict_put_str(qdict, "desc", "Expecting capabilities negoti=
ation"
>> -                          " with 'qmp_capabilities'");
>> -        }
>> -    }
>> -
>>      /* Respond if necessary */
>>      monitor_qmp_respond(mon, rsp, NULL, id);
>>
>> --
>> 2.17.0.rc1.1.g4c4f2b46a3
>>
>
> --
> Peter Xu
