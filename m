Received: from eggs.gnu.org ([2001:4830:134:3::10]:34264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgq0v-0001Fx-Kw
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgq0u-0006Eb-Pq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:48:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-6-git-send-email-armbru@redhat.com>
	<5eb9cc1f-527b-16a9-3ae9-e9993856b829@redhat.com>
Date: Thu, 23 Feb 2017 10:48:33 +0100
In-Reply-To: <5eb9cc1f-527b-16a9-3ae9-e9993856b829@redhat.com> (Eric Blake's
	message of "Wed, 22 Feb 2017 17:29:54 -0600")
Message-ID: <87shn5kzke.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 5/5] block: Crude initial
 implementation of -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/21/2017 03:01 PM, Markus Armbruster wrote:
>> The new command line option -blockdev works like QMP command
>> blockdev-add.
>> 
>> The option argument may be given in JSON syntax, exactly as in QMP.
>> Example usage:
>> 
>>     -blockdev '{"node-name": "foo", "driver": "raw", "file": {"driver": "file", "filename": "foo.img"} }'
>> 
>> The JSON argument doesn't exactly blend into the existing option
>> syntax, so the traditional KEY=VALUE,... syntax is also supported,
>> using dotted keys to do the nesting:
>> 
>>     -blockdev node-name=foo,driver=raw,file.driver=file,file.filename=foo.img
>
> Some of the list ideas were allowing mix-and-match or re-opening the
> dict; do we want to allow any of these? (maybe as followups?)
>
> -blockdev
> node-name=foo,driver=raw,file='{"driver":"file"}',file.filename=foo.img

No.  The initial version needs to be as simple as I can make it to give
me a chance at making 2.9.

Also, coming right from QemuOpts work, I'm in no mood for sugar.

>> Note that calling qmp_blockdev_add() (say via qmp_marshal_block_add())
>> right away would crash.  We need to stash the configuration for later
>> instead.  This is crudely done, and bypasses QemuOpts, even though
>> storing configuration is what QemuOpts is for.  Need to revamp option
>> infrastructure to support QAPI types like BlockdevOptions.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qemu-options.hx |  3 +++
>>  vl.c            | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 53 insertions(+)
>> 
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 9936cf3..36a38d7 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -512,6 +512,9 @@ Use @var{file} as CD-ROM image (you cannot use @option{-hdc} and
>>  using @file{/dev/cdrom} as filename (@pxref{host_drives}).
>>  ETEXI
>>  
>> +DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
>> +    "-blockdev FIXME document\n", QEMU_OPTION_blockdev)
>
> Adequate for an RFC, but I can see how you want to improve it.

:)

>> @@ -3095,6 +3104,37 @@ int main(int argc, char **argv, char **envp)
>>                  drive_add(IF_DEFAULT, popt->index - QEMU_OPTION_hda, optarg,
>>                            HD_OPTS);
>>                  break;
>> +            case QEMU_OPTION_blockdev:
>> +                {
>> +                    BlockdevOptions_queue *bdo = g_new(BlockdevOptions_queue, 1);
>> +                    bool is_json = optarg[0] == '{';
>> +                    QObject *obj;
>> +                    QDict *args;
>> +                    Visitor *v;
>> +
>> +                    if (is_json) {
>> +                        obj = qobject_from_json(optarg);
>> +                        // TODO get error out of parser
>
> Yeah, that's something we still need to improve.

Elsewhere, too:

    req = json_parser_parse_err(tokens, NULL, &err);
    if (err || !req || qobject_type(req) != QTYPE_QDICT) {
        if (!err) {
            error_setg(&err, QERR_JSON_PARSING);
        }
        goto err_out;
    }

>> +                        if (!obj) {
>> +                            error_report("invalid JSON");
>> +                            exit(1);
>> +                        }
>> +                        args = qobject_to_qdict(obj);
>> +                        assert(args);
>> +                        v = qobject_input_visitor_new(QOBJECT(args), true);
>> +                    } else {
>> +                        args = keyval_parse(optarg, "driver", &error_fatal);
>> +                        v = qobject_input_visitor_new_autocast(QOBJECT(args));
>> +                    }
>
> Pretty slick!  And answers my question: no mix-and-match of JSON and
> dotted (all one or the other) within a single -blockdev argument.

Thanks!  I think you can see where I'm trying to head: towards a
QAPIfied command line.
