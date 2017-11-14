Received: from eggs.gnu.org ([2001:4830:134:3::10]:35286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbN2-000397-7j
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbMw-0007Bh-2K
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:35:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEbMv-00079l-Oy
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:35:13 -0500
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
	<20171114081711.27640.38697.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <442df546-ea3a-6339-3e39-defad7ff3aac@redhat.com>
Date: Tue, 14 Nov 2017 14:34:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171114081711.27640.38697.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 07/26] replay: added replay log
 format description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 14/11/2017 09:17, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 
> This patch adds description of the replay log file format
> into the docs/replay.txt.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 
> ---
>  docs/replay.txt |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/docs/replay.txt b/docs/replay.txt
> index 486c1e0..c52407f 100644
> --- a/docs/replay.txt
> +++ b/docs/replay.txt
> @@ -232,3 +232,72 @@ Audio devices
>  Audio data is recorded and replay automatically. The command line for recording
>  and replaying must contain identical specifications of audio hardware, e.g.:
>   -soundhw ac97
> +
> +Replay log format
> +-----------------
> +
> +Record/replay log consits of the header and the sequence of execution
> +events. The header includes 4-byte replay version id and 8-byte reserved
> +field. Version is updated every time replay log format changes to prevent
> +using replay log created by another build of qemu.
> +
> +The sequence of the events describes virtual machine state changes.
> +It includes all non-deterministic inputs of VM, synchronization marks and
> +instruction counts used to correctly inject inputs at replay.
> +
> +Synchronization marks (checkpoints) are used for synchronizing qemu threads
> +that perform operations with virtual hardware. These operations may change
> +system's state (e.g., change some register or generate interrupt) and
> +therefore should execute synchronously with CPU thread.
> +
> +Every event in the log includes 1-byte event id and optional arguments.
> +When argument is an array, it is stored as 4-byte array length
> +and corresponding number of bytes with data.
> +Here is the list of events that are written into the log:
> +
> + - EVENT_INSTRUCTION. Instructions executed since last event.
> +   Argument: 4-byte number of executed instructions.
> + - EVENT_INTERRUPT. Used to synchronize interrupt processing.
> + - EVENT_EXCEPTION. Used to synchronize exception handling.
> + - EVENT_ASYNC. This is a group of events. They are always processed
> +   together with checkpoints. When such an event is generated, it is
> +   stored in the queue and processed only when checkpoint occurs.
> +   Every such event is followed by 1-byte checkpoint id and 1-byte
> +   async event id from the following list:
> +     - REPLAY_ASYNC_EVENT_BH. Bottom-half callback. This event synchronizes
> +       callbacks that affect virtual machine state, but normally called
> +       asyncronously.
> +       Argument: 8-byte operation id.
> +     - REPLAY_ASYNC_EVENT_INPUT. Input device event. Contains
> +       parameters of keyboard and mouse input operations
> +       (key press/release, mouse pointer movement).
> +       Arguments: 9-16 bytes depending of input event.
> +     - REPLAY_ASYNC_EVENT_INPUT_SYNC. Internal input synchronization event.
> +     - REPLAY_ASYNC_EVENT_CHAR_READ. Character (e.g., serial port) device input
> +       initiated by the sender.
> +       Arguments: 1-byte character device id.
> +                  Array with bytes were read.
> +     - REPLAY_ASYNC_EVENT_BLOCK. Block device operation. Used to synchronize
> +       operations with disk and flash drives with CPU.
> +       Argument: 8-byte operation id.
> +     - REPLAY_ASYNC_EVENT_NET. Incoming network packet.
> +       Arguments: 1-byte network adapter id.
> +                  4-byte packet flags.
> +                  Array with packet bytes.
> + - EVENT_SHUTDOWN. Occurs when user sends shutdown event to qemu,
> +   e.g., by closing the window.
> + - EVENT_CHAR_WRITE. Used to synchronize character output operations.
> +   Arguments: 4-byte output function return value.
> +              4-byte offset in the output array.
> + - EVENT_CHAR_READ_ALL. Used to synchronize character input operations,
> +   initiated by qemu.
> +   Argument: Array with bytes that were read.
> + - EVENT_CHAR_READ_ALL_ERROR. Unsuccessful character input operation,
> +   initiated by qemu.
> +   Argument: 4-byte error code.
> + - EVENT_CLOCK + clock_id. Group of events for host clock read operations.
> +   Argument: 8-byte clock value.
> + - EVENT_CHECKPOINT + checkpoint_id. Checkpoint for synchronization of
> +   CPU, internal threads, and asynchronous input events. May be followed
> +   by one or more EVENT_ASYNC events.
> + - EVENT_END. Last event in the log.
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
