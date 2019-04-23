Received: from eggs.gnu.org ([209.51.188.92]:40110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIzlI-0003aK-Un
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIzlG-0000Nm-P5
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:03:20 -0400
References: <20190422221714.7630-1-jsnow@redhat.com>
	<20190422221714.7630-3-jsnow@redhat.com>
	<a8aa6da5-7951-e42b-23b2-3718dec543e9@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <70ec70ea-02e0-b740-2523-a2cc0d650d06@redhat.com>
Date: Tue, 23 Apr 2019 14:03:00 -0400
MIME-Version: 1.0
In-Reply-To: <a8aa6da5-7951-e42b-23b2-3718dec543e9@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] docs/interop/bitmaps: rewrite and
 modernize doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aliang@redhat.com" <aliang@redhat.com>, "kchamart@redhat.com" <kchamart@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Fam Zheng <fam@euphon.net>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>



On 4/23/19 1:58 PM, Vladimir Sementsov-Ogievskiy wrote:
> 23.04.2019 1:17, John Snow wrote:
>> This just about rewrites the entirety of the bitmaps.rst document to
>> make it consistent with the 4.0 release. I have added new features seen
>> in the 4.0 release, as well as tried to clarify some points that keep
>> coming up when discussing this feature both in-house and upstream.
>>
>> Yes, it's a lot longer, mostly due to examples. I get a bit chatty.
>> I could use a good editor to help reign in my chattiness.
>>
>> It does not yet cover pull backups or migration details, but I intend to
>> keep extending this document to cover those cases.
>>
>> Please try compiling it with sphinx and look at the rendered output, I
>> don't have hosting to share my copy at present. I think this new layout
>> reads nicer in the HTML format than the old one did, at the expense of
>> looking less readable in the source tree itself (though not completely
>> unmanagable. We did decide to convert it from Markdown to ReST, after
>> all, so I am going all-in on ReST.)
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
> 
> [..]
> 
>> +Bitmap Status
>> +-------------
>> +
>> +Dirty Bitmap objects can be queried with the QMP command `query-block
>> +<qemu-qmp-ref.html#index-query_002dblock>`_, and are visible via the
>> +`BlockDirtyInfo <qemu-qmp-ref.html#index-BlockDirtyInfo>`_ QAPI structure.
>> +
>> +This struct shows the name, granularity, and dirty byte count for each bitmap.
>> +Additionally, it shows several boolean status indicators:
>> +
>> +- ``recording``: This bitmap is recording writes.
>> +- ``busy``: This bitmap is in-use by an operation.
>> +- ``persistent``: This bitmap is a persistent type.
>> +- ``inconsistent``: This bitmap is corrupted and cannot be used.
>> +
>> +The ``+busy`` status prohibits you from deleting, clearing, or otherwise
>> +modifying a bitmap, and happens when the bitmap is being used for a backup
>> +operation or is in the process of being loaded from a migration. Many of the
>> +commands documented below will refuse to work on such bitmaps.
>> +
>> +The ``+inconsistent`` status similarly prohibits almost all operations,
>> +notably allowing only the ``block-dirty-bitmap-remove`` operation.
>> +
>> +There is also a deprecated "`DirtyBitmapStatus
>> +<qemu-qmp-ref.html#index-DirtyBitmapStatus>`_" field. a bitmap historically
> 
> I think, better s/DirtyBitmapStatus/status/, to use field name, not type for what
> to call "field".
> 
> 
>> +had five visible states:
>> +
>> +   #. ``Frozen``: This bitmap is currently in-use by an operation and is
>> +      immutable. It can't be deleted, renamed, reset, etc.
>> +
>> +      (This is now ``+busy``.)
>> +
>> +   #. ``Disabled``: This bitmap is not recording new writes.
>> +
> 
> [..]
> 
>> +Example: Incremental Push Backups without Backing Files
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Backup images are best kept off-site, so we often will not have the preceding
>> +backups in a chain available to link against. This is not a problem at backup
>> +time; we simply do not set the backing image when creating the destination
>> +image:
>> +
>> +#. Create a new destination image with no backing file set. We will need to
>> +   specify the size of the base image this time, because it isn't available
>> +   for QEMU to use to guess:
> 
> hmm, s/to use to guess/to guess/ ?
> 

Good point.

>>   
>>      .. code:: bash
>>   
> 
> [..]
> 
>> +Example: Individual Failures
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Backup jobs that fail individually behave simply as described above. This
>> +example shows the simplest case:
> 
> Hmm, I think the simplest would be full backup without mode=existing :),
> so suggest just s/This example.../Consider example below:/, or s/Backup/Incremental backup/
> 
>> +
>> +#. Create a target image:
>> +
>> +   .. code:: bash
>> +
>> +       $ qemu-img create -f qcow2 drive0.inc0.qcow2 \
>> +         -b drive0.full.qcow2 -F qcow2
>> +
>> +#. Attempt to create an incremental backup via QMP:
>> +
>> +   .. code:: json
>> +
>> +    -> {
>> +         "execute": "drive-backup",
>> +         "arguments": {
>> +           "device": "drive0",
>> +           "bitmap": "bitmap0",
>> +           "target": "drive0.inc0.qcow2",
>> +           "format": "qcow2",
>> +           "sync": "incremental",
>> +           "mode": "existing"
>> +         }
>> +       }
>> +
>> +    <- { "return": {} }
>> +
>> +#. Receive a pair of events indicating failure:
>> +
>> +   .. code:: json
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "device": "drive0",
>> +           "action": "report",
>> +           "operation": "read"
>> +         },
>> +         "event": "BLOCK_JOB_ERROR"
>> +       }
>> +
>> +    <- {
>> +         "timestamp": {...},
>> +         "data": {
>> +           "speed": 0,
>> +           "offset": 0,
>> +           "len": 67108864,
>> +           "error": "No space left on device",
>> +           "device": "drive0",
>> +           "type": "backup"
>> +         },
>> +         "event": "BLOCK_JOB_COMPLETED"
>> +       }
> 
> a bit strange to get ENOSPC on read (understand that you use blkdebug),
> consider s/read/write/ just for beauty
> 

You are absolutely right, this doesn't make sense in the context of
something you'd see in the wild.

>>   
>> -4. Delete the failed incremental, and re-create the image.
>> +#. Delete the failed image, and re-create it.
>>   
>>      .. code:: bash
> 
> [..]
> 
>> +
>> +Example: Partial Transactional Failures
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +QMP commands like `drive-backup <qemu-qmp-ref.html#index-drive_002dbackup>`_
>> +conceptually only start a job, and so transactions containing these commands
>> +may succeed even if the job it created later fails. This might have surprising
>> +interactions with notions of how a "transaction" ought to behave.
>> +
>> +This distinction means that on occasion, a transaction containing such job
>> +launching commands may appear to succeed and return success, but later
>> +individual jobs associated with the transaction may fail. It is possible that
>> +a management application may have to deal with a partial backup failure after
>> +a "successful" transaction.
>> +
>> +If multiple backup jobs are specified in a single transaction, if one of those
>> +jobs fails, it will not interact with the other backup jobs in any way by
>> +default. The job(s) that succeeded will clear the dirty bitmap associated with
>> +the operation, but the job(s) that failed will not. It is therefore not safe
>> +to delete any incremental backups that were created successfully in this
>> +scenario, even though others failed.
>> +
>> +This example illustrates a transaction with two backup jobs, where one fails
>> +and one succeeds:
>> +
>> +#. Issue the transaction to start a backup of both drives. Note that the
>> +   transaction is accepted, indicating that the jobs are started succesfully.
> 
> And now this "note" looks strange, as it related not to this list item but to the next.
> Actually, we can't "note" that in context of this list item.
> 
>>   
>>      .. code:: json
>>   
>> -       { "execute": "transaction",
>> +    -> {
>> +         "execute": "transaction",
>>            "arguments": {
>>              "actions": [
>> -             { "type": "drive-backup",
>> -               "data": { "device": "drive0", "bitmap": "bitmap0",
>> -                         "format": "qcow2", "mode": "existing",
>> -                         "sync": "incremental", "target": "d0-incr-1.qcow2" } },
>> -             { "type": "drive-backup",
>> -               "data": { "device": "drive1", "bitmap": "bitmap1",
>> -                         "format": "qcow2", "mode": "existing",
>> -                         "sync": "incremental", "target": "d1-incr-1.qcow2" } },
>> -           ]
>> +           {
>> +             "type": "drive-backup",
>> +             "data": {
>> +               "device": "drive0",
>> +               "bitmap": "bitmap0",
>> +               "format": "qcow2",
>> +               "mode": "existing",
>> +               "sync": "incremental",
>> +               "target": "drive0.inc0.qcow2"
>> +             }
>> +           },
>> +           {
>> +             "type": "drive-backup",
>> +             "data": {
>> +               "device": "drive1",
>> +               "bitmap": "bitmap0",
>> +               "format": "qcow2",
>> +               "mode": "existing",
>> +               "sync": "incremental",
>> +               "target": "drive1.inc0.qcow2"
>> +             }
>> +           }]
>>            }
>>          }
>>   
>> --  QMP example response, highlighting one success and one failure:
>> +#. Receive notice that the Transaction was accepted, and jobs were
>> +   launched:
>>   
>> -   -  Acknowledgement that the Transaction was accepted and jobs were
>> -      launched:
>> +   .. code:: json
>> +
>> +    <- { "return": {} }
>> +
>> +#. Receive notice that the first job has completed:
>>   
> 
> [..]
> 
>> -      .. code:: json
>> +At the conclusion of the above example, ``drive0.inc0.qcow2`` is valid and
>> +must be kept, but ``drive1.inc0.qcow2`` is incomplete and should be
>> +deleted. If a VM-wide incremental backup of all drives at a point-in-time is
>> +to be made, new backups for both drives will need to be made, taking into
>> +account that a new incremental backup for drive0 needs to be based on top of
>> +``drive0.inc0.qcow2``.
>>   
>> -          { "timestamp": { "seconds": 1447192399, "microseconds": 683015 },
>> -            "data": { "device": "drive1", "action": "report",
>> -                      "operation": "read" },
>> -            "event": "BLOCK_JOB_ERROR" }
>> +In other words, at the conclusion of the above example, we'd have made only an
>> +incremental backup for drive0 but not drive1. The last VM-wide crash
>> +consistent backup we have access to in this case is the anchor point.
> 
> Not sure about "anchor point", can't be it applied to incremental backup point?
> May be just "full-backup point" or something like this?
> 

You're right, I don't really use this term too consistently. I always
refer to them as "anchors" because they're at "the bottom of the chain"
but I should at least explain this terminology if I am going to use it.

>>   
>> -      .. code:: json
>> +.. code:: text
>>   
>> -          { "timestamp": { "seconds": 1447192399, "microseconds":
>> -          685853 }, "data": { "speed": 0, "offset": 0, "len": 67108864,
>> -          "error": "Input/output error", "device": "drive1", "type":
>> -          "backup" }, "event": "BLOCK_JOB_COMPLETED" }
>> +          [drive0.full.qcow2] <-- [drive0.inc0.qcow2]
>> +          [drive1.full.qcow2]
>>   
>> --  In the above example, ``d0-incr-1.qcow2`` is valid and must be kept,
>> -   but ``d1-incr-1.qcow2`` is invalid and should be deleted. If a VM-wide
>> -   incremental backup of all drives at a point-in-time is to be made,
>> -   new backups for both drives will need to be made, taking into account
>> -   that a new incremental backup for drive0 needs to be based on top of
>> -   ``d0-incr-1.qcow2``.
>> +To repair this, issue a new incremental backup across both drives. The result
>> +will be backup chains that resemble the following:
>>   
> 
> [..]
> 
> With or without my nit-picking suggestions:
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

They're good suggestions, so I will revise them. Thank you for reviewing
such a large document!
