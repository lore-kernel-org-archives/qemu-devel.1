Received: from eggs.gnu.org ([2001:4830:134:3::10]:36698)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dVfcH-0001z3-HJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dVfc9-0006Z9-Oc
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:01:21 -0400
Received: from mx01.kamp.de ([82.141.2.16]:41606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dVfc9-0006YL-Fc
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:01:13 -0400
References: <20170710134436.GB6770@redhat.com>
	<20170710135218.GK5772@noname.redhat.com>
	<20170710135539.GD6770@redhat.com>
	<e7640733-88fa-230b-2631-d43e22404b16@kamp.de>
	<20170713092100.GD4011@redhat.com>
	<e0a85555-aaa9-c2d0-efc7-8a932ca8a915@kamp.de>
	<20170713140022.GN4011@redhat.com>
	<1f4ca3cc-b17b-b577-f5a7-5d550c387cb5@kamp.de>
	<20170713140711.GO4011@redhat.com>
	<4648fb64-c1ea-0962-0123-2326769a07c2@kamp.de>
	<20170713145801.GP4011@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <37d97fcb-aa71-1ed4-2134-6d308da7b527@kamp.de>
Date: Thu, 13 Jul 2017 17:00:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170713145801.GP4011@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 5/8] block/qcow2: read and write the
 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com

Am 13.07.2017 um 16:58 schrieb Daniel P. Berrange:
> On Thu, Jul 13, 2017 at 04:18:13PM +0200, Peter Lieven wrote:
>> Okay, so it has to be a mix of QAPI parsing and manual parameter checking,
>> right?
> Yeah. It does feel like a valid RFE for QAPI to add a permitted range to
> 'int' types though, which would simplify the code in future.
>
>> I currently have the following:
>>
>>      options = qemu_opts_to_qdict(opts, NULL);
>>      qdict_extract_subqdict(options, &compressopts, "compress.");
>>      v = qobject_input_visitor_new_keyval(QOBJECT(compressopts));
>>      visit_start_struct(v, NULL, NULL, 0, &local_err);
>>      if (local_err) {
>>          ret= -EINVAL;
>>          goto finish;
>>      }
>>      visit_type_Qcow2Compress_members(v, &compress, &local_err);
>>      if (local_err) {
>>          ret= -EINVAL;
>>          goto finish;
>>      }
>>      visit_end_struct(v, NULL);
>>      visit_free(v);
>>      QDECREF(compressopts);
>>      QDECREF(options)
> Looks good.
>
>> And I have the following 2 questions:
>>   a) I have to specifiy compress.format and compress.level otherwise I will get an error. How can I fix that the settings are optional?
> Put an '*' as the first character of any field name if it should be optional.
>
>>   b) If I just specify a compress.format can I default the compress.level to 0 without an error?
> I believe you'd get compress.level as 0 automatically for an 'int' type.

I still face the issue that I now always have to specify a compress.format. I tried to solve it like this:

     int compress_format = -1;
     uint8_t compress_level = 0;
     if (qemu_opt_find(opts, BLOCK_OPT_COMPRESS_FORMAT) ||
         qemu_opt_find(opts, BLOCK_OPT_COMPRESS_LEVEL)) {
         QDict *options, *compressopts = NULL;
         Qcow2Compress compress;
         Visitor *v;
         options = qemu_opts_to_qdict(opts, NULL);
         qdict_extract_subqdict(options, &compressopts, "compress.");
         v = qobject_input_visitor_new_keyval(QOBJECT(compressopts));
         visit_start_struct(v, NULL, NULL, 0, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             ret = -EINVAL;
             goto finish;
         }
         visit_type_Qcow2Compress_members(v, &compress, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             ret = -EINVAL;
             goto finish;
         }
         visit_end_struct(v, NULL);
         visit_free(v);
         QDECREF(compressopts);
         QDECREF(options);

         compress_format = compress.format;
         compress_level = compress.level;
         if (compress_format == QCOW2_COMPRESS_FORMAT_ZLIB &&
             compress_level > 9) {
             error_setg(errp, "Compress level %" PRIu8 " is not supported for"
                        " format '%s'", compress_level,
                        qemu_opt_get(opts, BLOCK_OPT_COMPRESS_FORMAT));
             ret = -EINVAL;
             goto finish;
         }
     }

Maybe there is a better option?

Peter
